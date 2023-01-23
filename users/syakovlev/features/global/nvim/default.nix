{
  inputs,
  pkgs,
  lib,
  ...
}: let
  buildPlugin = name:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
  normalizeName = let
    extension = name: "." + lib.last (lib.splitString "." name);
  in
    name:
      if lib.hasInfix "." name
      then lib.removeSuffix (extension name) name
      else name;
  configPlugins = plugins:
    map
    (plug:
      if builtins.pathExists ./nvim/${normalizeName plug.pname}.lua
      then {
        type = "lua";
        plugin = plug;
        config = builtins.readFile ./nvim/${normalizeName plug.pname}.lua;
      }
      else plug)
    plugins;
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    extraConfig = ''
      lua << EOF
      ${lib.strings.fileContents ./nvim/init.lua}
      EOF
    '';
    extraPackages = with pkgs; [
      alejandra
      nodePackages.prettier
      rust-analyzer
      gopls
      nil
      yaml-language-server
    ];
    plugins = with pkgs.vimPlugins;
      configPlugins [
        # LSP
        nvim-lspconfig
        lsp_signature-nvim
        lspsaga-nvim-original

        # UI
        telescope-nvim
        nvim-tree-lua
        marks-nvim
        lualine-nvim
        lualine-lsp-progress
        (buildPlugin "github-nvim-theme")
        #nvim-base16

        # Tree-sitter
        nvim-treesitter.withAllGrammars
        (buildPlugin "syntax-tree-surfer")
        playground

        # Completion
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer

        # Git
        diffview-nvim
        neogit
        gitsigns-nvim

        # Others
        formatter-nvim
        nvim-lint
        nvim-snippy
        nvim-autopairs
        vim-wordmotion
        vim-unimpaired
        comment-nvim
        hop-nvim
        surround-nvim
      ];
  };
}
