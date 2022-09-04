{ inputs, pkgs, lib, ... }:
let
  userName = "syakovlev";
  buildPlugin = name:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
  normalizeName =
    let extension = name: "." + lib.last (lib.splitString "." name);
    in name:
    if lib.hasInfix "." name then
      lib.removeSuffix (extension name) name
    else
      name;
  configPlugins = plugins:
    map (plug:
      if builtins.pathExists ./nvim/${normalizeName plug.pname}.lua then {
        type = "lua";
        plugin = plug;
        config = builtins.readFile ./nvim/${normalizeName plug.pname}.lua;
      } else
        plug) plugins;
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
        configPlugins [
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
          (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
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
          (buildPlugin "github-nvim-theme")
          (buildPlugin "navigator")
        ];
    };
  };
}
