{
  description = "My NixOS Configuration";
  inputs = {
    # Nix stuff
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # quickshell = {
    #   url = "github:outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   # inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    # };
    # helix = {
    #   url = "github:helix-editor/helix";
    # };
    catppuccin.url = "github:catppuccin/nix";
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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
      url = "github:cachix/git-hooks.nix";
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
    # colmena.url = "github:zhaofengli/colmena";

    # Secrets
    # ragenix = {
    #   url = "github:yaxitech/ragenix";
    #   #inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Packages
    # hyprland = {
    #   url = "github:hyprwm/Hyprland/v0.32.3";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # xdph = {
    #   url = "github:hyprwm/xdg-desktop-portal-hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Styles
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    # Neovim plugins
    "syntax-tree-surfer" = {
      url = "github:ziontee113/syntax-tree-surfer";
      flake = false;
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      ...
    }:
    let
      lib = nixpkgs.lib.extend (final: _: import ./nix/lib final);
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
        # make custom lib available to parent functions
        specialArgs = { inherit lib; };
      }
      {
        debug = false;
        imports = [
          (
            { inputs', ... }:
            {
              # make pkgs available to all `perSystem` functions
              _module.args.pkgs = inputs'.nixpkgs.legacyPackages;
              # make custom lib available to all `perSystem` functions
              _module.args.lib = lib;
            }
          )
          ./nix
          ./nixos
        ];
        systems = [ "x86_64-linux" ];
      };
}
