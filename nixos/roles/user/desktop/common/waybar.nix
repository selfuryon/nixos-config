{
  config,
  pkgs,
  inputs,
  ...
}: let
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
in {
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages."x86_64-linux".waybar-hyprland;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
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
        modules-center = ["wlr/workspaces"];
        modules-right = ["network" "wireplumber" "battery" "clock" "custom/hostname"];

        "wlr/workspaces" = {on-click = "activate";};
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
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "";
            headset = "";
            portable = "";
            default = ["" "" ""];
          };
          on-click = pavucontrol;
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
          format-icons = ["󱊡" "󱊢" "󱊣"];
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
        "custom/hostname" = {exec = "echo $USER@$(${hostname})";};
        "mpris" = {
          format = "{player_icon}";
          format-paused = "{status_icon}";
          format-stopped = "{status_icon}";
          player-icons = {
            default = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
            stopped = "";
          };
        };
      };
    };
    style = with config.scheme.withHashtag; ''
      * {
      font-family: "${config.themes.fontProfile.regular.family}";
      font-size: 12pt;
      padding: 0 8px;
      }
      .modules-right {
      margin-right: -15px;
      }
      .modules-left {
      margin-left: -15px;
      }
      window#waybar.top {
      opacity: 0.95;
      padding: 0;
      background-color: ${base00};
      border: 2px solid ${base0D};
      border-top-width: 4px;
      border-radius: 10px;
      }
      window#waybar {
      color: ${base05};
      }
      #workspaces * {
      padding: 0 4px;
      }
      #workspaces button {
      color: ${base05};
      border-radius: 0px;
      margin: 4px 2px;
      border-bottom: 4px solid ${base02};
      }
      #workspaces button.hidden {
      background-color: ${base00};
      color: ${base04};
      }
      #workspaces button.focused,
      #workspaces button.active {
      border-bottom: 4px solid ${base0D};
      }
      #custom-nixos {
      font-size: 12px;
      background-color: ${base0D};
      color: ${base00};
      padding-left: 15px;
      padding-right: 22px;
      margin-left: 0;
      margin-right: 10px;
      margin-top: 0;
      margin-bottom: 0;
      border-radius: 10px;
      }
      #custom-nixos.update {
      color: ${base08};
      }
      #battery.warning {
      background: ${base09};
      }
      #battery.critical {
      background: ${base08};
      }
      #custom-hostname {
      background-color: ${base0D};
      color: ${base00};
      padding-left: 15px;
      padding-right: 18px;
      margin-right: 0;
      margin-top: 0;
      margin-bottom: 0;
      border-radius: 10px;
      }
      #tray {
      color: ${base05};
      }
    '';
  };
}
