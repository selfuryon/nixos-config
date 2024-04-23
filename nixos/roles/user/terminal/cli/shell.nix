{pkgs, ...}: {
  home.shellAliases = {
    # Git
    gc = "${pkgs.git}/bin/git commit";
    gd = "${pkgs.git}/bin/git diff";
    ga = "${pkgs.git}/bin/git add";
    gs = "${pkgs.git}/bin/git status";
    gph = "${pkgs.git}/bin/git push";
    gl = "${pkgs.git}/bin/git ll";
    gpl = "${pkgs.git}/bin/git pull";
    lg = "${pkgs.lazygit}/bin/lazygit";

    # Nix
    nrs = "doas nixos-rebuild switch --flake path:/home/syakovlev/src/personal/nixos-config";
    nrb = "doas nixos-rebuild build --flake path:/home/syakovlev/src/personal/nixos-config";
    nfu = "nix flake update";

    # Kubernetes
    k = "kubectl";
    kx = "kubectx";
    kns = "kubens";
    tf = "terraform";
    tg = "terragrunt";

    # Other
    cat = "${pkgs.bat}/bin/bat --paging=never --style=plain";
    ip = "ip --color --brief";
    # less = "${pkgs.tailspin}/bin/tspin";
    more = "${pkgs.bat}/bin/bat --paging=always";
    tree = "${pkgs.eza}/bin/eza --tree";
    wget = "${pkgs.wget2}/bin/wget2";
  };

  home.sessionVariables = {
    EDITOR = "hx";
    KUBECONFIG = "/home/syakovlev/.config/kubernetes";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
      theme = {
        manager = {
          cwd = {fg = "#179299";};
          hovered = {
            fg = "#eff1f5";
            bg = "#1e66f5";
          };
          preview_hovered = {underline = true;};

          # Find
          find_keyword = {
            fg = "#df8e1d";
            italic = true;
          };
          find_position = {
            fg = "#ea76cb";
            bg = "reset";
            italic = true;
          };

          # Marker
          marker_selected = {
            fg = "#40a02b";
            bg = "#40a02b";
          };
          marker_copied = {
            fg = "#df8e1d";
            bg = "#df8e1d";
          };
          marker_cut = {
            fg = "#d20f39";
            bg = "#d20f39";
          };

          # Tab
          tab_active = {
            fg = "#eff1f5";
            bg = "#1e66f5";
          };
          tab_inactive = {
            fg = "#4c4f69";
            bg = "#bcc0cc";
          };
          tab_width = 1;

          # Border
          border_symbol = "│";
          border_style = {fg = "#8c8fa1";};
        };

        status = {
          separator_open = "";
          separator_close = "";
          separator_style = {
            fg = "#bcc0cc";
            bg = "#bcc0cc";
          };

          # Mode
          mode_normal = {
            fg = "#eff1f5";
            bg = "#1e66f5";
            bold = true;
          };
          mode_select = {
            fg = "#eff1f5";
            bg = "#40a02b";
            bold = true;
          };
          mode_unset = {
            fg = "#eff1f5";
            bg = "#dd7878";
            bold = true;
          };

          # Progress
          progress_label = {
            fg = "#ffffff";
            bold = true;
          };
          progress_normal = {
            fg = "#1e66f5";
            bg = "#bcc0cc";
          };
          progress_error = {
            fg = "#d20f39";
            bg = "#bcc0cc";
          };

          # Permissions
          permissions_t = {fg = "#1e66f5";};
          permissions_r = {fg = "#df8e1d";};
          permissions_w = {fg = "#d20f39";};
          permissions_x = {fg = "#40a02b";};
          permissions_s = {fg = "#8c8fa1";};
        };
        input = {
          border = {fg = "#1e66f5";};
          selected = {reversed = true;};
        };

        select = {
          border = {fg = "#1e66f5";};
          active = {fg = "#ea76cb";};
        };

        tasks = {
          border = {fg = "#1e66f5";};
          hovered = {underline = true;};
        };

        which = {
          mask = {bg = "#ccd0da";};
          cand = {fg = "#179299";};
          rest = {fg = "#7c7f93";};
          desc = {fg = "#ea76cb";};
          separator = "  ";
          separator_style = {fg = "#acb0be";};
        };

        help = {
          on = {fg = "#ea76cb";};
          exec = {fg = "#179299";};
          desc = {fg = "#7c7f93";};
          hovered = {
            bg = "#acb0be";
            bold = true;
          };
          footer = {
            fg = "#bcc0cc";
            bg = "#4c4f69";
          };
        };

        filetype = {
          rules = [
            # Images
            {
              mime = "image/*";
              fg = "#179299";
            }

            # Videos
            {
              mime = "video/*";
              fg = "#df8e1d";
            }
            {
              mime = "audio/*";
              fg = "#df8e1d";
            }

            # Archives
            {
              mime = "application/zip";
              fg = "#ea76cb";
            }
            {
              mime = "application/gzip";
              fg = "#ea76cb";
            }
            {
              mime = "application/x-tar";
              fg = "#ea76cb";
            }
            {
              mime = "application/x-bzip";
              fg = "#ea76cb";
            }
            {
              mime = "application/x-bzip2";
              fg = "#ea76cb";
            }
            {
              mime = "application/x-7z-compressed";
              fg = "#ea76cb";
            }
            {
              mime = "application/x-rar";
              fg = "#ea76cb";
            }

            {
              name = "*";
              fg = "#4c4f69";
            }
            {
              name = "*/";
              fg = "#1e66f5";
            }
          ];
        };
      };
    };
    bat = {
      enable = true;
      config.theme = "GitHub";
      extraPackages = with pkgs.bat-extras; [
        batwatch
        prettybat
      ];
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = true;
    };
    broot = {
      enable = true;
      settings.modal = true;
    };
    jq.enable = true;
  };
}
