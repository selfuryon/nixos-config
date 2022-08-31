{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    "github-nvim-theme" = {
      url = "github:projekt0n/github-nvim-theme";
      flake = false;
    };
    # LSP
    "navigator" = {
      url = "github:ray-x/navigator.lua";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, deploy-rs, ... }@inputs:
    let
      # Load lib
      lib = nixpkgs.lib;
      myLib = import ./lib.nix lib;

      # My overlays
      overlays = [ (import ./overlays) ];

      # Load inventory
      # inventory = import ./machines/inventory.nix;
      inventory = myLib.createInventory ./machines;

      # Make system configuration, given hostname and system type
      mkSystem = { hostname, system, users, roles, ... }:
        let
          userNames = builtins.attrNames users;
          userList = builtins.map (u: ./users/${u}) userNames;
          rolePaths = builtins.map (r: ./roles/${r}.nix) roles;
          roleList = builtins.filter (p: builtins.pathExists p) rolePaths;
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname system roles; };
          modules = [
            inputs.ragenix.nixosModules.age
            inputs.lollypops.nixosModules.lollypops
            { nixpkgs = { inherit overlays; }; }
            (./machines/${hostname})
          ] ++ roleList ++ userList;
        };
      # Make Deploy-rs node
      mkDeployNode = { hostname, system, sshUser, sudo ? "sudo -u", ... }: {
        hostname = "${hostname}";
        sshUser = "${sshUser}";
        sudo = "${sudo}";
        profilesOrder = [ "system" ];
        profiles = {
          system = {
            user = "root";
            path = deploy-rs.lib."${system}".activate.nixos
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
    };
}
