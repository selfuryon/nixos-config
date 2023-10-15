{
  description = "My NixOS Configuration";
  inputs = {
    # Nix stuff
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
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
    pre-commit-hooks-nix = {
      url = "github:hercules-ci/pre-commit-hooks.nix/flakeModule";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utils
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      url = "github:hyprwm/Hyprland/v0.30.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Styles
    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/base16-schemes";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };

    # Neovim plugins
    "syntax-tree-surfer" = {
      url = "github:ziontee113/syntax-tree-surfer";
      flake = false;
    };
    "neorg" = {
      url = "github:nvim-neorg/neorg/v5.0.0";
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
        ./nix
        ./nixos
      ];
      systems = ["x86_64-linux"];
    };
}
