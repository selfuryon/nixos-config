{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    deploy-rs.url = "github:serokell/deploy-rs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, utils
    , deploy-rs, ... }@inputs:
    let
      # My overlays
      overlays = [ (import ./overlays) neovim-nightly-overlay.overlay ];

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hostname inputs system; };
          modules = [
            (./machines + "/${hostname}")
            {
              networking.hostName = hostname;
              # Apply overlay
              nixpkgs = { inherit overlays; };
              # Add each input as a registry
              nix.registry = nixpkgs.lib.mapAttrs'
                (n: v: nixpkgs.lib.nameValuePair (n) ({ flake = v; })) inputs;
            }
            # System wide config for each user
          ] ++ nixpkgs.lib.forEach users (u: ./users + "/${u}" + /system.nix);
        };

      # Make home configuration, given username, required features, and system type
      mkHome = { username, system, hostname, features ? [ ] }:
        home-manager.lib.homeManagerConfiguration {
          inherit username system;
          extraSpecialArgs = { inherit features hostname inputs system; };
          homeDirectory = "/home/${username}";
          configuration = ./users + "/${username}";
          extraModules = [{ nixpkgs = { inherit overlays; }; }];
        };
    in {
      nixosConfigurations = {
        # Main laptop
        jumo = mkSystem {
          hostname = "jumo";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
        # V2D HBastion
        v2d-hbastion = mkSystem {
          hostname = "v2d-hbastion";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
        # SB HBastion
        sb-hbastion = mkSystem {
          hostname = "sb-hbastion";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
      };

      homeConfigurations = {
        # Main Laptop
        "syakovlev@jumo" = mkHome {
          username = "syakovlev";
          hostname = "jumo";
          features = [ "cli" "sway-desktop" "music" "development" ];
          system = "x86_64-linux";
        };
        # V2D HBastion
        "syakovlev@v2d-hbastion" = mkHome {
          username = "syakovlev";
          hostname = "v2d-hbastion";
          features = [ "cli" ];
          system = "x86_64-linux";
        };
        # SB HBastion
        "syakovlev@sb-hbastion" = mkHome {
          username = "syakovlev";
          hostname = "sb-hbastion";
          features = [ "cli" ];
          system = "x86_64-linux";
        };
      };

      # Deploy-rs
      deploy.nodes = {
        sb-hbastion = {
          hostname = "sb-hbastion";
          sshUser = "syakovlev";
          profilesOrder = [ "system" "syakovlev" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.sb-hbastion;
            };
            syakovlev = {
              user = "syakovlev";
              path = deploy-rs.lib.x86_64-linux.activate.home-manager
                self.homeConfigurations."syakovlev@sb-hbastion";
            };
          };
        };
        v2d-hbastion = {
          hostname = "v2d-hbastion";
          sshUser = "syakovlev";
          profilesOrder = [ "system" "syakovlev" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.v2d-hbastion;
            };
            syakovlev = {
              user = "syakovlev";
              path = deploy-rs.lib.x86_64-linux.activate.home-manager
                self.homeConfigurations."syakovlev@v2d-hbastion";
            };
          };
        };
        jumo = {
          hostname = "jumo";
          sshUser = "syakovlev";
          profilesOrder = [ "system" "syakovlev" ];
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.jumo;
            };
            syakovlev = {
              user = "syakovlev";
              path = deploy-rs.lib.x86_64-linux.activate.home-manager
                self.homeConfigurations."syakovlev@jumo";
            };
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell { packages = [ nixfmt ]; };

    };
}
