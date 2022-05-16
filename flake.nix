{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";

    deploy-rs.url = "github:serokell/deploy-rs";
    colmena.url = "github:zhaofengli/colmena";
  };

  outputs = { self, nixpkgs, home-manager, deploy-rs, ... }@inputs:
    let
      # My overlays
      overlays = [ (import ./overlays) inputs.neovim-overlay.overlay ];

      # Load inventory
      inventory = import ./machines/inventory.nix;

      # Load lib
      lib = nixpkgs.lib;
      myLib = import ./lib.nix lib;

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hostname inputs system; };
          modules = [
            (./machines + "/${hostname}")
            {
              # Apply overlay
              nixpkgs = { inherit overlays; };
              # Add each input as a registry
              nix.registry = nixpkgs.lib.mapAttrs (n: v: { flake = v; }) inputs;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit hostname inputs system nixpkgs; };
                users = nixpkgs.lib.mapAttrs (user: features:
                  import (./users + "/${user}") {
                    features = users.syakovlev.features;
                    lib = nixpkgs.lib;
                  }) users;
              };
            }
            # System wide config for each user
          ] ++ nixpkgs.lib.forEach (builtins.attrNames users)
            (u: ./users + "/${u}" + /system.nix);
        };
    in {
      roles = myLib.findRoles ./roles;
      nixosConfigurations =
        lib.mapAttrs (name: config: mkSystem config) inventory;

      # Deploy-rs
      deploy.nodes = {
        sb-hbastion = {
          hostname = "sb-hbastion";
          sshUser = "syakovlev";
          profilesOrder = [ "system" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.sb-hbastion;
            };
          };
        };
        v2d-hbastion = {
          hostname = "v2d-hbastion";
          sshUser = "syakovlev";
          profilesOrder = [ "system" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.v2d-hbastion;
            };
          };
        };
        jumo = {
          hostname = "jumo";
          sshUser = "syakovlev";
          profilesOrder = [ "system" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.jumo;
            };
          };
        };
      };
      colmena = {
        meta = { nixpkgs = import nixpkgs { system = "x86_64-linux"; }; };

        sb-hbastion = self.nixosConfigurations.sb-hbastion.config;
        v2d-hbastion = self.nixosConfigurations.v2d-hbastion.config;
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          packages = [
            nixfmt
            inputs.deploy-rs.defaultPackage.x86_64-linux
            inputs.colmena.defaultPackage.x86_64-linux
          ];
        };

    };
}
