{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
    nodePackages.prettier
    rust-analyzer
    gopls
    nil
    yaml-language-server
    #lsp-ai
    #helix-gpt
  ];
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
            args = [ ];
          };
        }
        {
          name = "cue";
          language-servers = [ "cuelsp" ];
          formatter = {
            args = [ ];
          };
        }
      ];
      language-server = {
        cuelsp = {
          command = "${pkgs.cue-master}/bin/cue";
          args = [
            "lsp"
            "-remote=unix;/run/user/1000/cuelsp" # TODO: find a way to use XDG_RUNTIME_DIR
          ];
        };
      };
    };
    settings = {
      # theme = "catppuccin_latte";
      keys.normal = {
        space.space = "file_picker";
      };
      editor = {
        auto-save = true;
        true-color = true;
        color-modes = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };
        soft-wrap = {
          enable = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
  systemd.user.services = {
    cuelsp = {
      Unit = {
        Description = "Run cuelsp as a daemon";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.cue-master}/bin/cue lsp -vv serve -listen=unix;%t/cuelsp";
        ExecStopPost = "/run/current-system/sw/bin/rm -f %t/cuelsp";
        Restart = "always";
        RestartSec = 3;
        MemoryHigh = "1.5G";
        MemoryMax = "2G";
        Environment = [ ];
      };
    };
  };
}
