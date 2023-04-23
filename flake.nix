{
  description = "My NixOS Configuration";
  inputs = {
    # Nix stuff
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-root.url = "github:srid/flake-root";
    pre-commit-hooks-nix = {
      url = "github:hercules-ci/pre-commit-hooks.nix/flakeModule";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mission-control.url = "github:Platonic-Systems/mission-control";

    # Utils
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deploy
    colmena.url = "github:zhaofengli/colmena";

    # Secrets
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Styles
    base16 = {
      url = "github:SenchoPens/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
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
  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }: let
    lib = nixpkgs.lib.extend (final: _: import ./nix/lib final);
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
      # make custom lib available to parent functions
      specialArgs = {inherit lib;};
    }
    {
      debug = true;
      imports = [
        ({inputs', ...}: {
          # make pkgs available to all `perSystem` functions
          _module.args.pkgs = inputs'.nixpkgs.legacyPackages;
          # make custom lib available to all `perSystem` functions
          _module.args.lib = lib;
        })
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.flake-root.flakeModule
        inputs.mission-control.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        ./nix
        ./nixos
      ];
      systems = ["x86_64-linux"];
    };
}
