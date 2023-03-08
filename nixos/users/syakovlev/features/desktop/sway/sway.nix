{
  config,
  lib,
  pkgs,
  ...
}: let
  sway_mod = "Mod4";
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Orchis-Light'
      gsettings set $gnome_schema icon-theme 'Tela'
      gsettings set $gnome_schema cursor-theme 'capitaine-cursors'
      gsettings set $gnome_schema font-name 'Inter 12'
    '';
  };
in {
  imports = [../common];
  home.packages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    wayland
    glib # gsettings
    qt5.qtwayland
    libsForQt5.lightly
    wlogout
    #swaotificationcenter
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = false; # sway-session.target

    config = {
      bars = [{command = "waybar";}];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      modifier = "${sway_mod}";
      menu = "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wofi}/bin/wofi --show drun -i | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      fonts = {
        names = ["JetBrainsMono Nerd Font"];
        size = 10.0;
      };

      focus.followMouse = "no";
      window.border = 1;
      floating.border = 2;
      gaps.inner = 10;

      # Input configuration
      input."type:keyboard" = {
        xkb_layout = "us,ru";
        xkb_options = "grp:shift_caps_switch";
      };
      input."type:touchpad" = {
        dwt = "enabled";
        tap = "enabled";
        natural_scroll = "enabled";
        middle_emulation = "enabled";
        pointer_accel = "0.7";
      };

      # Output configuration
      output."*" = {bg = "/home/syakovlev/Pictures/wife2.jpg fill";};
      output."eDP-1" = {
        mode = "1920x1080";
        pos = "0,2160";
      };

      startup = [
        # Services
        {command = "swaync";}
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
        {
          command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        }
        {command = "dbus-sway-environment";}
        {command = "configure-gtk";}
      ];

      assigns = {
        "20" = [{app_id = "code";}];
        "30" = [{class = "firefox";}];
        "40" = [{class = "Thunderbird";}];
        "80" = [
          {class = "Slack";}
          {class = "discord";}
          {app_id = "telegramdesktop";}
        ];
        "90" = [{class = "KeePassXC";}];
      };

      floating.criteria = [
        {window_role = "pop-up";}
        {window_role = "task_dialog";}
        {app_id = "nz.co.mega.";}
        {app_id = "org.keepassxc.KeePassXC";}
      ];

      window.commands = [
        {
          criteria = {floating = true;};
          command = "border pixel 2";
        }
        {
          criteria = {workspace = "3";};
          command = "layout tabbed";
        }
        {
          criteria = {workspace = "8";};
          command = "layout tabbed";
        }
        {
          criteria = {class = "firefox";};
          command = "inhibit_idle fullscreen";
        }
        {
          criteria = {app_id = "pavucontrol";};
          command = "floating enable, sticky enable, resize set width 550 px height 600px, move position cursor, move down 100";
        }
        {
          criteria = {class = "MEGAsync";};
          command = "floating enable, move position center";
        }
        {
          criteria = {title = "Firefox — Sharing Indicator";};
          command = "floating enable, no_focus, resize set 0 0, move absolute position 10 10";
        }
      ];

      keybindings = let
        inherit (config.wayland.windowManager.sway.config) modifier;
      in
        lib.mkOptionDefault {
          # Control volume
          XF86AudioRaiseVolume = "exec pamixer -i 5";
          XF86AudioLowerVolume = "exec pamixer -d 5";
          XF86AudioMute = "exec pamixer -t";
          #XF86AudioMicMute = "";

          # Control media
          #XF86AudioPlay  = "exec playerctl play-pause";
          #XF86AudioPause = "exec playerctl play-pause";
          #XF86AudioNext  = "exec playerctl next";
          #XF86AudioPrev  = "exec playerctl previous";

          # Control brightness
          XF86MonBrightnessUp = "exec light -A 5";
          XF86MonBrightnessDown = "exec light -U 5";

          # Screenshots
          "print" = ''exec grim -g "$(slurp)" - | swappy -f -'';
          "Shift+print" = "exec grim - | swappy -f -";

          # Focus
          "${modifier}+z" = "focus child";

          # Lock
          "${modifier}+Shift+x" = "exec ${pkgs.swaylock}/bin/swaylock -f";

          # Exit
          "${modifier}+Shift+e" = "${pkgs.wlogout}/bin/wlogout";

          # Workspaces
          "${modifier}+1" = "mode ws1";
          "${modifier}+Shift+1" = "mode cws1";
          "${modifier}+2" = "mode ws2";
          "${modifier}+Shift+2" = "mode cws2";

          "${modifier}+3" = "workspace number 30";
          "${modifier}+Shift+3" = "move container to workspace number 30";
          "${modifier}+4" = "workspace number 40";
          "${modifier}+Shift+4" = "move container to workspace number 40";
          "${modifier}+5" = "workspace number 50";
          "${modifier}+Shift+5" = "move container to workspace number 50";
          "${modifier}+6" = "workspace number 60";
          "${modifier}+Shift+6" = "move container to workspace number 60";
          "${modifier}+7" = "workspace number 70";
          "${modifier}+Shift+7" = "move container to workspace number 70";
          "${modifier}+8" = "workspace number 80";
          "${modifier}+Shift+8" = "move container to workspace number 80";
          "${modifier}+9" = "workspace number 90";
          "${modifier}+Shift+9" = "move container to workspace number 90";
          "${modifier}+0" = "workspace number 100";
          "${modifier}+Shift+0" = "move container to workspace number 100";

          # Moving workspaces between screens
          "${modifier}+Mod1+Up" = "move workspace to output up";
          "${modifier}+Mod1+Down" = "move workspace to output down";
          "${modifier}+Mod1+Left" = "move workspace to output left";
          "${modifier}+Mod1+Right" = "move workspace to output right";

          # swaync
          "${modifier}+Shift+n" = "exec swaync-client -t -sw";
          # Marks
          "${modifier}+m" = ''
            exec swaymsg "mark --toggle $(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.focused==true) | .marks []' | wofi -d)" '';
          "${modifier}+grave" = ''
            exec swaymsg "[con_mark=$(swaymsg -t get_marks | jq -r '. []' | wofi -d)] focus"
          '';
        };
    };

    extraConfig = ''
      mode "ws1" {
          bindsym 0 mode default, workspace 10
          bindsym ${sway_mod}+0 mode default, workspace 10
          bindsym 1 mode default, workspace 11
          bindsym ${sway_mod}+1 mode default, workspace 11
          bindsym 2 mode default, workspace 12
          bindsym ${sway_mod}+2 mode default, workspace 12
          bindsym 3 mode default, workspace 13
          bindsym ${sway_mod}+3 mode default, workspace 13
          bindsym 4 mode default, workspace 14
          bindsym ${sway_mod}+4 mode default, workspace 14
          bindsym 5 mode default, workspace 15
          bindsym ${sway_mod}+5 mode default, workspace 15
          bindsym 6 mode default, workspace 16
          bindsym ${sway_mod}+6 mode default, workspace 16
          bindsym 7 mode default, workspace 17
          bindsym ${sway_mod}+7 mode default, workspace 17
          bindsym 8 mode default, workspace 18
          bindsym ${sway_mod}+8 mode default, workspace 18
          bindsym 9 mode default, workspace 19
          bindsym ${sway_mod}+9 mode default, workspace 19
          bindsym Escape mode "default"
          bindsym Return mode "default"
      }

      mode "ws2" {
          bindsym 0 mode default, workspace 20
          bindsym ${sway_mod}+0 mode default, workspace 20
          bindsym 1 mode default, workspace 21
          bindsym ${sway_mod}+1 mode default, workspace 21
          bindsym 2 mode default, workspace 22
          bindsym ${sway_mod}+2 mode default, workspace 22
          bindsym 3 mode default, workspace 23
          bindsym ${sway_mod}+3 mode default, workspace 23
          bindsym 4 mode default, workspace 24
          bindsym ${sway_mod}+4 mode default, workspace 24
          bindsym 5 mode default, workspace 25
          bindsym ${sway_mod}+5 mode default, workspace 25
          bindsym 6 mode default, workspace 26
          bindsym ${sway_mod}+6 mode default, workspace 26
          bindsym 7 mode default, workspace 27
          bindsym ${sway_mod}+7 mode default, workspace 27
          bindsym 8 mode default, workspace 28
          bindsym ${sway_mod}+8 mode default, workspace 28
          bindsym 9 mode default, workspace 29
          bindsym ${sway_mod}+9 mode default, workspace 29
          bindsym Escape mode "default"
          bindsym Return mode "default"
      }

      mode "cws1" {
          bindsym 0 mode default, move container to workspace 10
          bindsym 1 mode default, move container to workspace 11
          bindsym 2 mode default, move container to workspace 12
          bindsym 3 mode default, move container to workspace 13
          bindsym 4 mode default, move container to workspace 14
          bindsym 5 mode default, move container to workspace 15
          bindsym 6 mode default, move container to workspace 16
          bindsym 7 mode default, move container to workspace 17
          bindsym 8 mode default, move container to workspace 18
          bindsym 9 mode default, move container to workspace 19
      }


      mode "cws2" {
          bindsym 0 mode default, move container to workspace 20
          bindsym 1 mode default, move container to workspace 21
          bindsym 2 mode default, move container to workspace 22
          bindsym 3 mode default, move container to workspace 23
          bindsym 4 mode default, move container to workspace 24
          bindsym 5 mode default, move container to workspace 25
          bindsym 6 mode default, move container to workspace 26
          bindsym 7 mode default, move container to workspace 27
          bindsym 8 mode default, move container to workspace 28
          bindsym 9 mode default, move container to workspace 29
      }
      # Setting cursor theme
      seat seat0 xcursor_theme capitaine-cursors 16
      # Disable laptop screen on lid action
      bindswitch --reload --locked lid:on output eDP-1 disable
      bindswitch --reload --locked lid:off output eDP-1 enable

      # Google light theme: https://github.com/rkubosz/base16-sway/blob/master/themes/base16-google-light.config
      set $base00 #ffffff
      set $base01 #e0e0e0
      set $base02 #c5c8c6
      set $base03 #b4b7b4
      set $base04 #969896
      set $base05 #373b41
      set $base06 #282a2e
      set $base07 #1d1f21
      set $base08 #CC342B
      set $base09 #F96A38
      set $base0A #FBA922
      set $base0B #198844
      set $base0C #3971ED
      set $base0D #3971ED
      set $base0E #A36AC7
      set $base0F #3971ED
      client.focused          $base05 $base0D $base00 $base0D $base0D
      client.focused_inactive $base01 $base01 $base05 $base03 $base01
      client.unfocused        $base01 $base00 $base05 $base01 $base01
      client.urgent           $base08 $base08 $base00 $base08 $base08
      client.placeholder      $base00 $base00 $base05 $base00 $base00
      client.background       $base07
    '';
  };
}
