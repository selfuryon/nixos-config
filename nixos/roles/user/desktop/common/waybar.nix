{ pkgs, ... }:
let
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  hostname = "${pkgs.nettools}/bin/hostname";
  curl = "${pkgs.curl}/bin/curl";
  jq = "${pkgs.jq}/bin/jq";
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils-full}/bin/cut";

  checkNixosUpdates = pkgs.writeShellScript "checkUpdates.sh" ''
    UPDATE='{"text": "Update", "alt": "update", "class": "update"}'
    NO_UPDATE='{"text": "No Update", "alt": "noupdate", "class": "noupdate"}'

    GITHUB_URL="https://api.github.com/repos/NixOS/nixpkgs/git/refs/heads/nixos-unstable"
    #CURRENT_REVISION=$(nixos-version --revision)
    CURRENT_REVISION=$(${cat} /run/current-system/nixos-version | ${cut} -d. -f4)
    REMOTE_REVISION=$(${curl} -s $GITHUB_URL | ${jq} '.object.sha' -r )
    [[ $CURRENT_REVISION == ''${REMOTE_REVISION:0:7} ]] && echo $NO_UPDATE || echo $UPDATE
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        layer = "top";
        height = 40;
        margin = "6";
        position = "top";
        modules-left = [
          "custom/nixos"
          "tray"
          "idle_inhibitor"
          "mpris"
        ];
        modules-center = [
          "niri/workspaces"
        ];
        modules-right = [
          "custom/notifications"
          "network"
          "wireplumber"
          "battery"
          "clock"
          "custom/hostname"
        ];
        "custom/notifications" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };
        "niri/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            term = "";
            code = "";
            browser = "";
            mail = "";
            im = "";
            secret = "󰟵";
            default = "";
            #active= "";
          };
        };
        "custom/nixos" = {
          exec = checkNixosUpdates;
          on-click = checkNixosUpdates;
          return-type = "json";
          format = "{icon}";
          format-icons = {
            update = "";
            noupdate = "";
          };
          interval = 10800;
        };
        clock = {
          format = "󱑌  {:%H:%M}";
          format-alt = "󰸗 {:%d %B %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        wireplumber = {
          format = "  {volume}%";
          format-muted = "󰝟  0%";
          on-click = pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        battery = {
          bat = "BAT0";
          interval = 40;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = [
            "󱊡"
            "󱊢"
            "󱊣"
          ];
          format = "{icon} {capacity}%";
          format-charging = "󱊥 {capacity}%";
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈀  Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };
        "custom/hostname" = {
          exec = "echo $USER@$(${hostname})";
        };
        "mpris" = {
          format = "{player_icon}";
          format-paused = "{status_icon}";
          format-stopped = "{status_icon}";
          player-icons = {
            default = "";
            firefox = "";
          };
          status-icons = {
            paused = "󰏦";
            stopped = "󰙧";
          };
        };
      };
    };
    style = ''
      * {
        font-family: "Symbols Nerd Font Mono", "JetBrains Mono" ;
        font-size: 12pt;
      }

      .modules-right * {
        padding: 0 6px;
      }
      .modules-left * {
        padding: 0 6px;
      }

      window#waybar {
        opacity: 0.95;
        background-color: @base;
        border: 2px solid @blue;
        border-top-width: 4px;
        border-radius: 10px;
      }

      #workspaces * {
        padding: 0 4px;
      }

      #workspaces button {
        color: @text;
        border-radius: 0px;
        margin: 4px 2px;
        border-bottom: 4px solid @surface0;
      }

      #workspaces button.hidden {
        color: @surface2;
        background-color: @base;
      }

      #workspaces button.focused,
      #workspaces button.active {
        border-bottom: 4px solid @blue;
      }

      #custom-nixos {
        font-size: 14px;
        color: @base;
        background-color: @blue;
        padding: 0 20px;
        margin: 0 6px 0 0;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      #custom-nixos.update {
        color: @red;
      }

      #battery.warning {
        background: @peach;
      }

      #battery.critical {
        background: @red;
      }

      #custom-hostname {
        color: @base;
        background-color: @blue;
        padding: 0 20px;
        margin: 0 0 0 6px;
        border-top-left-radius: 10px;
        border-bottom-left-radius: 10px;
      }

      #tray * {
        color: @text;
      }
    '';
  };
}
