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
  configPlugins =
    map
    (plug:
      # TODO: statix parses paths like `./${hostname}.nix` wrong: https://github.com/nerdypepper/statix/issues/68
        if builtins.pathExists (./. + "/nvim/${normalizeName plug.pname}.lua")
        then {
          type = "lua";
          plugin = plug;
          # TODO: statix parses paths like `./${hostname}.nix` wrong: https://github.com/nerdypepper/statix/issues/68
          config = builtins.readFile (./. + "/nvim/${normalizeName plug.pname}.lua");
        }
        else plug);
in {
  programs.neovim = {
    #package = inputs.neovim.packages."x86_64-linux".neovim;
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
        which-key-nvim

        # Git
        diffview-nvim
        gitsigns-nvim
        #neogit

        # Others
        formatter-nvim
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
