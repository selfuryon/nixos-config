{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, utils, ...  }@inputs:
    let
      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            (./hosts + "/${hostname}")
            {
              networking.hostName = hostname;
              # Add each input as a registry
              nix.registry = nixpkgs.lib.mapAttrs'
                (n: v:
                  nixpkgs.lib.nameValuePair (n) ({ flake = v; }))
                inputs;
            }
            # System wide config for each user
          ] ++ nixpkgs.lib.forEach users
            (u: ./users + "/${u}" + /system.nix);
        };
      # Make home configuration, given username, required features, and system type
      mkHome = { username, system, hostname }:
        home-manager.lib.homeManagerConfiguration {
          inherit username system;
          extraSpecialArgs = {
            inherit hostname inputs system;
          };
          homeDirectory = "/home/${username}";
          configuration = ./users + "/${username}";
        };
    in {
      nixosConfigurations = {
        # Main laptop
        jumo = mkSystem {
          hostname = "jumo";
          system = "x86_64-linux";
          users = [ "syakovlev" ];
        };
      };

      homeConfigurations = {
        "syakovlev@jumo" = mkHome {
          username = "syakovlev";
          hostname = "jumo";
          system = "x86_64-linux";
        };
      };
  };
}
