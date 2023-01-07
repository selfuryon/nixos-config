{ inputs, config, pkgs, ... }:
let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";
  ikhal = "${pkgs.khal}/bin/ikhal";

  terminal = "${pkgs.alacritty}/bin/alacritty";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";

  calendar = terminal-spawn ikhal;
  systemMonitor = terminal-spawn btm;

  checkNixosUpdates = pkgs.writeShellScript "checkUpdates.sh" ''
    UPDATE='{"text": "Update", "alt": "update", "class": "update"}'
    NO_UPDATE='{"text": "No Update", "alt": "noupdate", "class": "noupdate"}'

    GITHUB_URL="https://api.github.com/repos/NixOS/nixpkgs/git/refs/heads/nixos-unstable"
    CURRENT_REVISION=$(nixos-version --revision)
    REMOTE_REVISION=$(curl -s $GITHUB_URL | jq '.object.sha' -r )
    [ $CURRENT_REVISION == $REMOTE_REVISION ] && echo $NO_UPDATE || echo $UPDATE
  '';
  # Function to simplify making waybar outputs
  jsonOutput = name:
    { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? ""
    }:
    "${
      pkgs.writeShellScriptBin "waybar-${name}" ''
        set -euo pipefail
        ${pre}
        ${jq} -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      ''
    }/bin/waybar-${name}";
in {
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages."x86_64-linux".waybar-hyprland;
    settings = {
      # secondary = {
      # mode = "dock";
      # layer = "top";
      # height = 32;
      # width = 100;
      # margin = "6";
      # position = "bottom";
      # modules-center = [ "wlr/workspaces" ];

      # "wlr/workspaces" = { on-click = "activate"; };
      # };
      # primary = {
      # mode = "dock";
      # layer = "top";
      # height = 40;
      # margin = "6";
      # position = "top";
      # modules-left = [
      # "custom/nixos"
      # "idle_inhibitor"
      # "custom/currentplayer"
      # "custom/player"
      # ];
      # modules-center = [ "cpu" "memory" "clock" "pulseaudio" ];
      # modules-right = [ "network" "battery" "tray" "custom/hostname" ];

      # "custom/nixos" = {
      # exec = checkNixosUpdates;
      # on-click = checkNixosUpdates;
      # return-type = "json";
      # format = "{icon}";
      # format-icons = {
      # update = "";
      # noupdate = "";
      # };
      # interval = 10800;
      # };
      # clock = {
      # format = "{:%d/%m %H:%M}";
      # tooltip-format = ''
      # <big>{:%Y %B}</big>
      # <tt><small>{calendar}</small></tt>'';
      # on-click = calendar;
      # };
      # cpu = {
      # format = "   {usage}%";
      # on-click = systemMonitor;
      # };
      # memory = {
      # format = "  {}%";
      # interval = 5;
      # on-click = systemMonitor;
      # };
      # pulseaudio = {
      # format = "{icon}  {volume}%";
      # format-muted = "   0%";
      # format-icons = {
      # headphone = "";
      # headset = "";
      # portable = "";
      # default = [ "" "" "" ];
      # };
      # on-click = pavucontrol;
      # };
      # idle_inhibitor = {
      # format = "{icon}";
      # format-icons = {
      # activated = "零";
      # deactivated = "鈴";
      # };
      # };
      # battery = {
      # bat = "BAT0";
      # interval = 10;
      # format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
      # format = "{icon} {capacity}%";
      # format-charging = " {capacity}%";
      # onclick = "";
      # };
      # network = {
      # interval = 3;
      # format-wifi = "   {essid}";
      # format-ethernet = " Connected";
      # format-disconnected = "";
      # tooltip-format = ''
      # {ifname}
      # {ipaddr}/{cidr}
      # Up: {bandwidthUpBits}
      # Down: {bandwidthDownBits}'';
      # on-click = "";
      # };
      # "custom/hostname" = {
      # exec = "echo $USER@$(hostname)";
      # on-click = terminal;
      # };
      # "custom/currentplayer" = {
      # interval = 2;
      # return-type = "json";
      # exec = jsonOutput "currentplayer" {
      # pre = ''
      # player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No players found" | cut -d '.' -f1)"'';
      # alt = "$player";
      # tooltip = "$player";
      # };
      # format = "{icon}";
      # format-icons = {
      # "No players found" = "ﱘ";
      # "Celluloid" = "";
      # "spotify" = "阮";
      # "ncspot" = "阮";
      # "qutebrowser" = "爵";
      # "firefox" = "";
      # "discord" = "ﭮ";
      # "sublimemusic" = "";
      # };
      # on-click = "${playerctld} shift";
      # on-click-right = "${playerctld} unshift";
      # };
      # "custom/player" = {
      # exec-if = "${playerctl} status";
      # exec = ''
      # ${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
      # return-type = "json";
      # interval = 2;
      # max-length = 30;
      # format = "{icon} {}";
      # format-icons = {
      # "Playing" = "契";
      # "Paused" = " ";
      # "Stopped" = "栗";
      # };
      # on-click = "${playerctl} play-pause";
      # };
      # };
      mainBar = {
        layer = "top";
        height = 42;
        spacing = 5;
        position = "top";
        modules-left = [ "custom/nixos" "tray" "mpd" "idle_inhibitor" ];
        modules-center = [ "sway/workspaces" "wlr/workspaces" ];
        modules-right = [ "pulseaudio" "clock" "clock#calendar" "battery" ];
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
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          "format-icons" = {
            default = " ";
            focused = " ";
          };
        };
        "wlr/workspaces" = {
          all-outputs = true;
          "on-click" = "activate";
          format = "{name}";
        };
        tray = {
          icon-size = 19;
          spacing = 5;
        };
        mpd = {
          format = "{stateIcon}";
          format-stopped = "";
          interval = 10;
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        clock = { format = " {:%R}"; };
        "clock#calendar" = { format = " {:%Y-%m-%d}"; };
        battery = {
          bat = "BAT0";
          interval = 40;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{volume}% {icon}";
          format-muted = " ";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };
      };
    };
    # Heavily inspired by https://github.com/Rashad-707/dotfiles
    # style = let
    # inherit (config.colorscheme) colors;
    # # css
    # in ''
    # * {
    # font-family: "JetBrainsMono Nerd Font Mono", "Font Awesome 6 Free";
    # font-size: 12pt;
    # padding: 0 8px;
    # }
    # .modules-right {
    # margin-right: -15px;
    # }
    # .modules-left {
    # margin-left: -15px;
    # }
    # window#waybar.top {
    # opacity: 0.95;
    # padding: 0;
    # background-color: #${colors.base00};
    # border: 2px solid #${colors.base0C};
    # border-radius: 10px;
    # }
    # window#waybar.bottom {
    # opacity: 0.90;
    # background-color: #${colors.base00};
    # border: 2px solid #${colors.base0C};
    # border-radius: 10px;
    # }
    # window#waybar {
    # color: #${colors.base05};
    # }
    # #workspaces button {
    # background-color: #${colors.base01};
    # color: #${colors.base05};
    # margin: 4px;
    # }
    # #workspaces button.hidden {
    # background-color: #${colors.base00};
    # color: #${colors.base04};
    # }
    # #workspaces button.focused,
    # #workspaces button.active {
    # background-color: #${colors.base0A};
    # color: #${colors.base00};
    # }
    # #clock {
    # background-color: #${colors.base0C};
    # color: #${colors.base00};
    # padding-left: 15px;
    # padding-right: 15px;
    # margin-top: 0;
    # margin-bottom: 0;
    # border-radius: 10px;
    # }
    # #custom-nixos {
    # background-color: #${colors.base0C};
    # color: #${colors.base00};
    # padding-left: 15px;
    # padding-right: 22px;
    # margin-left: 0;
    # margin-right: 10px;
    # margin-top: 0;
    # margin-bottom: 0;
    # border-radius: 10px;
    # }
    # #custom-hostname {
    # background-color: #${colors.base0C};
    # color: #${colors.base00};
    # padding-left: 15px;
    # padding-right: 18px;
    # margin-right: 0;
    # margin-top: 0;
    # margin-bottom: 0;
    # border-radius: 10px;
    # }
    # #tray {
    # color: #${colors.base05};
    # }
    # '';
    #};
    style = ''
      * {
      font-family: "JetBrainsMono Nerd Font Mono", "Font Awesome 6 Free";
      font-size: 14px;
      border: 3px;
      border-radius: 12px;
      margin: 0 0 0 0;
      padding: 0 0 0 0;
      min-height: 21px;
      }
      window#waybar {
      background: transparent;
      }
      window#waybar.hidden {
      opacity: 0.8;
      }

      .modules-left {
      background: white;
      border: 3px solid white;
      margin: 4px 4px 0px 4px;
      }
      .modules-center {
      background: white;
      margin: 4px 4px 0px 4px;
      }
      .modules-right {
      background: white;
      border: 3px solid white;
      margin: 4px 4px 0px 4px;
      }

      #custom-nixos {
      font-size: 30px;
      color: white;
      background: #e4b371;
      border-radius: 12px 0px 0px 12px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #custom-nixos.update {
      color: red;
      }
      #tray {
      background: #6CA8CF;
      border-radius: 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #mpd {
      font-size: 21px;
      background: #7CA198;
      border-radius: 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #idle_inhibitor {
      font-size: 26px;
      color: white;
      background: #8e6d98;
      border-radius: 0px 12px 12px 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #workspaces {
      background: white;
      padding-left: 15px;
      padding-right: 15px;
      }
      #workspaces button {
      padding-left: 5px;
      padding-right: 5px;
      }
      #workspaces button.focused {
      color: #6080B0;
      }
      #pulseaudio {
      color: white;
      background: #8e6d98;
      border-radius: 12px 0px 0px 12px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #clock {
      color: white;
      background: #7CA198;
      border-radius: 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #clock.calendar {
      color: white;
      background: #6CA8CF;
      border-radius: 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #battery {
      color: white;
      background: #e4b371;
      border-radius: 0px 12px 12px 0px;
      padding-left: 15px;
      padding-right: 15px;
      }
      #battery.critical {
      background: #cf222e;
      }
    '';
  };
}
