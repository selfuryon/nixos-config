{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";
    colmena.url = "github:zhaofengli/colmena";
  };

  outputs = { self, nixpkgs, deploy-rs, ... }@inputs:
    let
      mapAttrs = nixpkgs.lib.mapAttrs;
      # My overlays
      overlays = [ (import ./overlays) ];

      # Load inventory
      inventory = import ./machines/inventory.nix;

      # Load lib
      lib = nixpkgs.lib;
      myLib = import ./lib.nix lib;

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname system users; };
          modules = [
            { nixpkgs = { inherit overlays; }; }
            (./machines + "/${hostname}")
            ./users
          ];
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
