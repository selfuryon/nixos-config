{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, utils, ... }@inputs:
    let
      # My overlays
      overlay = (import ./overlays);
      overlays = [ overlay ];

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hostname inputs system; };
          modules = [
            (./hosts + "/${hostname}")
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
      inherit overlay overlays;

      nixosConfigurations = {
        # Main laptop
        jumo = mkSystem {
          hostname = "jumo";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
        # HBastion
        v2d-hbastion = mkSystem {
          hostname = "v2d-hbastion";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
      };

      homeConfigurations = {
        # Main Laptop
        "syakovlev@jumo" = mkHome {
          username = "syakovlev";
          hostname = "jumo";
          features = [ "cli" "sway-desktop" "music" ];
          system = "x86_64-linux";
        };
        # HBastion
        "syakovlev@v2d-hbastion" = mkHome {
          username = "syakovlev";
          hostname = "v2d-hbastion";
          features = [ "cli" ];
          system = "x86_64-linux";
        };
      };
    } // utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ nixfmt rnix-lsp ]; };
      });
}
