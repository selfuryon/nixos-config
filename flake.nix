{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    hyprland = { url = "github:hyprwm/Hyprland"; };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    "syntax-tree-surfer" = {
      url = "github:ziontee113/syntax-tree-surfer";
      flake = false;
    };
    "github-nvim-theme" = {
      url = "github:projekt0n/github-nvim-theme";
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
      mkSystem = { hostname, system, users, ... }:
        let
          userList = builtins.map (u: ./users/${u}) users;
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname system; };
          modules = [
            inputs.ragenix.nixosModules.age
            inputs.nur.nixosModules.nur
            { nixpkgs = { inherit overlays; }; }
            (./machines/${hostname})
          ] ++ userList;
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
            inputs.deploy-rs.defaultPackage.x86_64-linux
            inputs.ragenix.defaultPackage.x86_64-linux
          ];
        };
    };
}
