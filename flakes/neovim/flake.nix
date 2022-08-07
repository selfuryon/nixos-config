{
  description = "My neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      #inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Required
    "plugin:plenary" = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    "plugin:nvim-web-devicons" = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    "plugin:githua" = {
      url = "github:ray-x/guihua.lua";
      flake = false;
    };
    "plugin:diffview" = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };

    # UI
    "plugin:github-nvim-theme" = {
      url = "github:projekt0n/github-nvim-theme";
      flake = false;
    };
    "plugin:lualine" = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };
    "plugin:nvim-toggleterm" = {
      url = "github:akinsho/nvim-toggleterm.lua";
      flake = false;
    };
    #"plugin:marks"= {url= "github:chentau/marks.nvim";flake=false;};

    # Navigation
    "plugin:telescope" = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    "plugin:nvim-tree" = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
    "plugin:vim-tmux-navigator" = {
      url = "github:christoomey/vim-tmux-navigator";
      flake = false;
    };

    # LSP
    "plugin:nvim-lspconfig" = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "plugin:lsp_signature" = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };
    "plugin:symbols-outline" = {
      url = "github:simrat39/symbols-outline.nvim";
      flake = false;
    };
    "plugin:navigator" = {
      url = "github:ray-x/navigator.lua";
      flake = false;
    };

    # Completion/Formation
    "plugin:cmp-nvim-lsp" = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    "plugin:cmp-buffer" = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    "plugin:nvim-cmp" = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    "plugin:formatter" = {
      url = "github:mhartington/formatter.nvim";
      flake = false;
    };
    "plugin:nvim-lint" = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };

    # Treesitter
    "plugin:nvim-treesitter" = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    "plugin:nvim-treesitter-textobjects" = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };

    # Snippets
    "plugin:nvim-snippy" = {
      url = "github:dcampos/nvim-snippy";
      flake = false;
    };

    # Git
    "plugin:neogit" = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    "plugin:gitsigns" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    # Motions
    "plugin:nvim-autopairs" = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    "plugin:vim-wordmotion" = {
      url = "github:chaoren/vim-wordmotion";
      flake = false;
    };
    "plugin:vim-unimpaired" = {
      url = "github:tpope/vim-unimpaired";
      flake = false;
    };
    "plugin:vim-commentary" = {
      url = "github:tpope/vim-commentary";
      flake = false;
    };
    "plugin:hop" = {
      url = "github:phaazon/hop.nvim";
      flake = false;
    };
    "plugin:surround" = {
      url = "github:ur4ltz/surround.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pluginOverlay = lib.buildPluginOverlay;

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            pluginOverlay
            (final: prev: {
              neovim-unwrapped =
                inputs.neovim.packages.${prev.system}.neovim;
            })
          ];
        };

        lib = import ./lib { inherit pkgs inputs; };
        neovimBuilder = lib.neovimBuilder;
      in rec {
        defaultApp = packages.neovimSY;
        defaultPackage = packages.neovimSY;

        overlay = self: super: {
          inherit neovimBuilder;
          neovimSY = packages.neovimSY;
          neovimPlugins = pkgs.neovimPlugins;
        };

        packages.neovimSY = neovimBuilder {
          config = import ./config.nix;
          debug = false;
        };
        devShells.default = with pkgs; mkShell { packages = [ nixfmt ]; };
      });
}
