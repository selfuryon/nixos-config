{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    hyprland = {url = "github:hyprwm/Hyprland";};
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16 = {
      url = "github:SenchoPens/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    mission-control.url = "github:Platonic-Systems/mission-control";
    statix = {
      url = "github:nerdypepper/statix";
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

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = import ./nix/lib {lib = nixpkgs.lib;} // nixpkgs.lib;
    system = "x86_64-linux";

    # Load inventory
    # inventory = import ./machines/inventory.nix;
    inventory = lib.createInventory ./machines;

    # Make system configuration, given hostname and system type
    mkSystem = {
      hostname,
      system,
      users,
      ...
    }: let
      userList = builtins.map (u: ./users/${u}) users;
    in
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs hostname system;};
        modules = [./machines/${hostname}] ++ userList;
      };
    # Make Deploy-rs node
    mkDeployNode = {
      hostname,
      system,
      sshUser,
      sudo ? "sudo -u",
      ...
    }: {
      hostname = "${hostname}";
      sshUser = "${sshUser}";
      sudo = "${sudo}";
      profilesOrder = ["system"];
      profiles = {
        system = {
          user = "root";
          path =
            deploy-rs.lib."${system}".activate.nixos
            self.nixosConfigurations.${hostname};
        };
      };
    };
  in {
    overlays = import ./overlays;
    homeManagerModules = import ./modules/home-manager;
    nixosModules = import ./modules/nixos;
    nixosConfigurations =
      lib.mapAttrs (name: mkSystem) inventory;

    deploy.nodes = lib.mapAttrs (name: mkDeployNode) inventory;

    checks =
      builtins.mapAttrs
      (system: deployLib: deployLib.deployChecks self.deploy)
      deploy-rs.lib;

    devShells.${system}.default = with nixpkgs.legacyPackages.${system};
      mkShell {
        packages = [
          inputs.deploy-rs.defaultPackage.${system}
          inputs.ragenix.defaultPackage.${system}
          statix
        ];
      };
    formatter.${system} = inputs.treefmt-nix.lib.mkWrapper nixpkgs.legacyPackages.${system} {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        prettier.enable = true;
      };
    };
  };
}
