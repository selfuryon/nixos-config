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
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      mkSystem = { hostname, system, users, ... }:
        let userList = builtins.attrNames users;
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname system users; };
          modules = [
            inputs.ragenix.nixosModules.age
            { nixpkgs = { inherit overlays; }; }
            (./machines + "/${hostname}")
          ] ++ lib.forEach userList (f: ./users + "/${f}");
        };
      mkDeployNode = { hostname, system, sshUser, ... }: {
        hostname = "${hostname}";
        sshUser = "${sshUser}";
        profilesOrder = [ "system" ];
        profiles = {
          system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.${hostname};
          };
        };
      };
    in {
      roles = myLib.findRoles ./roles;

      nixosConfigurations =
        lib.mapAttrs (name: config: mkSystem config) inventory;

      deploy.nodes = lib.mapAttrs (name: config: mkDeployNode config) inventory;

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          packages = [
            nixfmt
            inputs.deploy-rs.defaultPackage.x86_64-linux
            inputs.ragenix.defaultPackage.x86_64-linux
          ];
        };

    };
}
