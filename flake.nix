{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovimSY.url = "path:./flakes/neovim";
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lollypops.url = "github:pinpox/lollypops";
  };

  outputs = { self, nixpkgs, deploy-rs, ... }@inputs:
    let
      # My overlays
      overlays = [ (import ./overlays) ];

      # Load inventory
      inventory = import ./machines/inventory.nix;

      # Load lib
      lib = nixpkgs.lib;

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users, roles, ... }:
        let userList = builtins.attrNames users;
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname system roles; };
          modules = [
            inputs.ragenix.nixosModules.age
            inputs.lollypops.nixosModules.lollypops
            { nixpkgs = { inherit overlays; }; }
            (./machines + "/${hostname}")
          ] ++ lib.forEach roles (r: ./roles + "/${r}.nix")
            ++ lib.forEach userList (u: ./users + "/${u}");
        };
      # Make Deploy-rs node
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

      apps."x86_64-linux".default =
        inputs.lollypops.apps."x86_64-linux".default { configFlake = self; };
    };
}
