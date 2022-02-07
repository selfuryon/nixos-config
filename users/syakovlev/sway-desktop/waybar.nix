{ config, lib, pkgs, ... }: 
let
  checkNixosUpdates = pkgs.writeShellScript "checkUpdates.sh" ''
    UPDATE='{"text": "Update", "alt": "upd"}'
    NO_UPDATE='{"text": "No Update", "alt": "noupd"}'

    GITHUB_URL="https://api.github.com/repos/NixOS/nixpkgs/git/refs/heads/nixos-unstable"
    CURRENT_REVISION=$(nixos-version --revision)
    REMOTE_REVISION=$(curl -s $GITHUB_URL | jq '.object.sha' -r )
    [ $CURRENT_REVISION == $REMOTE_REVISION ] && echo $NO_UPDATE || echo $UPDATE
  '';
in {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      height = 42;
      position = "top";
      modules-left = [
        "sway/workspaces"
        "sway/mode"
        "idle_inhibitor"
      ];
      modules-center = [
        "sway/window"
      ];
      modules-right = [
        "pulseaudio"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "tray"
        "clock"
        "custom/update"
      ];
      modules = {
        "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            "format-icons" = {
                "1"  = "";
                "2"  = "";
                "3"  = "";
                "4"  = "";
                "5"  = "";
                "6"  = "";
                "7"  = "";
                "8"  = "";
                "9"  = "";
                "10" = "";
                default = "";
                focused = "";
                urgent  = "";
            };
            icon-size = 24;
        };
        "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
        };
        tray = {
            icon-size = 21;
            spacing = 5;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "custom/update" = {
          exec = checkNixosUpdates;
          return-type = "json";
          format = "{icon}";
          format-icons = { 
            upd = ""; 
          };
          interval = 21600;
        };
        clock = {
            format = "{:%R}";
            format-alt = "{:%Y-%m-%d}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        cpu = {
            format = "{usage}% ";
        };
        memory = {
            format = "{}% ";
        };
        temperature = {
            thermal-zone = 2;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
            critical-threshold = 80;
            format-critical = "{temperatureC}°C {icon}";
            format = "{temperatureC}°C {icon}";
            interval = 60;
            format-icons = ["" "" ""];
        };
        battery = {
          bat = "BAT0";
          interval = 40;
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
        };
        network = {
          interval = 5;
          format-wifi = "{essid}  ";
          format-ethernet = "Connected ";
          format-disconnected = "";
          on-click-middle = "exec alacritty -e nmtui";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        pulseaudio = {
          on-click = "pavucontrol";
          format = "{volume}% {icon}";
          format-muted = "0%  ";
          format-icons = {
            headphone = "";
            headset = "";
            portable = "";
            default = [ "" "" "" ];
          };
        };
      };
    }];
    style = ''
      * {
        border: none;
        font-size: 14px;
        margin: 1px;
        font-family: "JetBrainsMono Nerd Font Mono", "Font Awesome 5 Free";
      }
      window#waybar {
        background-color: #353b49;
        color: #d8dee9;
      }
      #workspaces {
        background-color: #2e3440;
        padding: 1px 1px 1px 1px;
        font-size: 12px;
        font-family: "Font Awesome 5 Free";
        border-radius: 10px;
      }
      #workspaces button {
          padding: 0 1px;
          min-width: 30px;
        font-size: 12px;
        border-radius: 0px;
        margin: 0;
        background-color: transparent;
        color: #ffffff;
      }
      #window {
        color: #d8dee9;
        margin: 0px;
        border-radius: 10px;
        padding: 0px 6px 0px 6px;
      }
      #window.empty {
        background-color: transparent;
      }
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        box-shadow: inherit;
        color: #5e81ac;
      }
      #workspaces button.focused,#tags button.occupied {
        color: #81a1c1;
      }
      #tags button.focused {
        color: #5e81ac;
      }
      #workspaces button.urgent {
        color: #eb4d4b;
      }
      #tags button {
        font-family: Product Sans ,Arial, Helvetica, sans-serif;
        font-weight: 600;
      }
      #mpd {
        padding: 0px 10px;
        color: #ffffff;
      }
      /* TASKBAR */
      #taskbar {
        margin: 2px 0px 2px 0px;
      }
      #taskbar button {
        border-radius: 10px;
        margin: 0px 5px 0px 5px;
        padding: 0px 6px 0px 6px;
        background-color: #2e3440;
      }
      #taskbar button.active {
        background-color: #3b4252;
        color: #81a1c1;
      }
      #taskbar button.minimized {
        color: #ebcb8b;
      }
      #taskbar button:hover {
        box-shadow: inherit;
        background-color: rgba(35,39,49,0.4);
      }
      /* BROWSER BOOKMARKS */
      #custom-newtab, #custom-name, #custom-github,#custom-reddit,#custom-crunchyroll,#custom-youtube,#custom-mail, #custom-library {
        background-color: transparent;
        font-size: 14px;
        padding: 0px 15px 0px 15px ;
      }
      #custom-newtab {
        color: #bf616a;
        font-size: 18px;
      }
      #custom-github {
        color: #d08770;
      }
      #custom-reddit {
        color: #ebcb8b;
      }
      #custom-library {
        color: #c57078;
      }
      #custom-crunchyroll {
        font-size: 13px;
        color: #a3be8c;
      }
      #custom-youtube {
        font-size: 13px;
        color: #b48ead;
      }
      #custom-mail {
        color: #88c0d0;
        font-size: 17px;
      }
      /* WIDGETS */
      #cpu, #idle_inhibitor, #custom-pacman, #memory, #backlight, #disk, #network, #pulseaudio, #custom-weather, #temperature, #mpd {
        background-color: #2e3440;
        padding: 0px 14px 0px 14px;
        margin: 2px 0px 2px 0px;
      }
      #disk {
        color:#b48ead;
      }
      #memory {
        color:#d08770;
      }
      #cpu {
        color:#c57078;
      }
      #custom-weather {
        color:#81a1c1;
      }
      #custom-weather {
        padding: 0px 8px 0px 8px;
      }
      #custom-media {
        color: #818896;
        border-radius: 10px;
        margin-left: 5px;
      }
      #custom-media.Playing {
        color: #81a1c1;
        border-radius: 0px;
        font-weight: 500;
      }
      #custom-media.Music {
        color: #b48ead;
        border-radius: 0px;
        font-weight: 500;
      }
      #custom-pacman {
        color: #ebcb8b;
        border-radius: 0px 10px 10px 0px;
        font-weight: 600;
        margin-right: 5px;
      }
      #pulseaudio {
        color: #8fbcbb;
        border-radius: 10px 0px 0px 10px;
      }
      #pulseaudio.muted {
        border-radius: 10px;
        color: #4c566a;
      }
      #temperature{
        color: #88c0d0;
      }
      #temperature.critical {
        color: #eb4d4b;
      }
      #battery {
        color: #8fbcbb;
        padding: 0px 8px 0px 8px;
      }
      #battery.charging {
        color: #ffffff;
      }
      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }
      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      label:focus {
        background-color: #000000;
      }
      #idle_inhibitor {
        font-size: 20px;
        color: #6f7787;
      }
      #idle_inhibitor.activated {
        color: #ffffff;
      }
      #clock, #custom-power, #custom-recorder, #tray {
        background-color: #3b4252;
        padding: 2px 10px 2px 10px;
        margin: 2px 0px 2px 0px;
      }
      #clock {
        font-size: 14px;
      }
      #custom-recorder {
        color:#c57078;
        padding: 2px 5px 2px 5px;
        font-size: 18px;
      }
      #tray {
        border-radius: 10px 0px 0px 10px;
        margin-left: 8px;
        color: #8fbcbb;
      }
      #custom-power {
        font-size: 17px;
        border-radius: 0px 10px 10px 0px;
        margin-right: 2px;
      }
      #mpd.disconnected {
        background-color: #f53c3c;
      }
      #mpd.stopped {
        background-color: #90b1b1;
      }
      #mpd.paused {
        background-color: #51a37a;
      }
    '';
  };
}
