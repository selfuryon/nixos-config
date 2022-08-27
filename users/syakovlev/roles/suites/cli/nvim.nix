{ inputs, pkgs, lib, ... }:
let
  userName = "syakovlev";
  buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
  treesitterGrammars =
    pkgs.tree-sitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
  plugins = builtins.filter (s: (builtins.match "plugin:.*" s) != null)
    (builtins.attrNames inputs);
  plugName = input:
    builtins.substring (builtins.stringLength "plugin:")
    (builtins.stringLength input) input;
  buildPlug = name:
    buildVimPluginFrom2Nix {
      pname = plugName name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
  neovimPlugins = map (plugin: {
    type = "lua";
    plugin = buildPlug plugin;
    config = if builtins.pathExists ./nvim/${plugin}.lua then
      lib.strings.fileContents ./nvim/${plugin}.lua
    else
      "";
  }) plugins;
in {
  home-manager.users.${userName} = {
    #home.packages = [ inputs.neovimSY.defaultPackage.x86_64-linux ];
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
      extraPackages = with pkgs; [ gopls rust-analyzer ];
      plugins = with pkgs.vimPlugins;
        [
          diffview-nvim
          lualine-nvim
          toggleterm-nvim
          marks-nvim
          telescope-nvim
          nvim-tree-lua
          nvim-lspconfig
          lsp_signature-nvim
          symbols-outline-nvim
          cmp-nvim-lsp
          cmp-buffer
          nvim-cmp
          formatter-nvim
          nvim-lint
          #nvim-treesitter
          (nvim-treesitter.withPlugins
            (plugins: pkgs.tree-sitter.allGrammars))
          nvim-treesitter-textobjects
          nvim-snippy
          neogit
          gitsigns-nvim
          nvim-autopairs
          vim-wordmotion
          vim-unimpaired
          vim-commentary
          hop-nvim
          surround-nvim
        ] ++ neovimPlugins;
    };
  };
}
