{ pkgs, ... }:
let
  userName = "syakovlev";
  checkNixosUpdates = pkgs.writeShellScript "checkUpdates.sh" ''
    UPDATE='{"text": "Update", "alt": "update", "class": "update"}'
    NO_UPDATE='{"text": "No Update", "alt": "noupdate", "class": "noupdate"}'

    GITHUB_URL="https://api.github.com/repos/NixOS/nixpkgs/git/refs/heads/nixos-unstable"
    CURRENT_REVISION=$(nixos-version --revision)
    REMOTE_REVISION=$(curl -s $GITHUB_URL | jq '.object.sha' -r )
    [ $CURRENT_REVISION == $REMOTE_REVISION ] && echo $NO_UPDATE || echo $UPDATE
  '';
in {
  home-manager.users.${userName} = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 42;
          spacing = 5;
          position = "top";
          modules-left = [ "custom/nixos" "tray" "mpd" "idle_inhibitor" ];
          modules-center = [ "sway/workspaces" ];
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
            format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
            format = "{icon} {capacity}%";
            format-charging = "{capacity}% ";
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
          padding-left: 0px;
          padding-right: 0px;
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
      '';
    };
  };
}
