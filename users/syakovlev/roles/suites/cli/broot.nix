{ pkgs, config, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    programs.broot = {
      enable = true;
      enableFishIntegration = true;
      verbs = [
        {
          invocation = "p";
          execution = ":parent";
        }
        {
          invocation = "edit";
          shortcut = "e";
          execution = "$EDITOR {file}";
        }
        {
          invocation = "create {subpath}";
          execution = "$EDITOR {directory}/{subpath}";
        }
        {
          invocation = "view";
          execution = "less {file}";
        }
        {
          invocation = "blop {name}\\.{type}";
          execution =
            "mkdir {parent}/{type} && ${pkgs.neovim}/bin/nvim {parent}/{type}/{name}.{type}";
          from_shell = true;
        }
      ];
    };
  };
}
