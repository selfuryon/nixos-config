{ config, lib, pkgs, ... }:
let
  userName = "syakovlev";
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

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
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
      gsettings set $gnome_schema gtk-theme 'WhiteSur-light-alt-blue'
      gsettings set $gnome_schema icon-theme 'WhiteSur'
      gsettings set $gnome_schema cursor-theme 'capitaine-cursors'
      gsettings set $gnome_schema font-name 'Noto Sans 12'
    '';
  };
in {
  # ws1: terminal
  # ws2: code
  # ws3: browser
  # ws4: mail
  # ws5: files
  # ws6: media
  # ws7: editor
  # ws8: chat
  # ws9: secure
  # ws10: general
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [ ];
  };

  home-manager.users.${userName} = {
    home.packages = with pkgs; [
      dbus-sway-environment
      configure-gtk
      wayland
      glib # gsettings
    ];

    home.sessionVariables = {
      #MOZ_ENABLE_WAYLAND = 1;
      #SDL_VIDEODRIVER = wayland;
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "sway";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      GTK_USE_PORTAL = 1;
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      systemdIntegration = true; # sway-session.target
      config = {
        bars = [{ command = "waybar"; }];
        terminal = "${pkgs.alacritty}/bin/alacritty";
        modifier = "Mod4"; # Windows
        menu =
          "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wofi}/bin/wofi --show drun -i | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        fonts = {
          names = [ "JetBrainsMono Nerd Font Mono" ];
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
        output."*" = { bg = "/home/syakovlev/Pictures/wife2.jpg fill"; };
        output."DP-1" = {
          mode = "3840x2160";
          pos = "0,0";
        };

        output."eDP-1" = {
          mode = "1920x1080";
          pos = "0,2160";
        };

        output."HDMI-A-1" = {
          mode = "1280x720";
          pos = "1920,2160";
        };

        startup = [
          # Services
          { command = "wlsunset"; }
          { command = "mako"; }
          {
            command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
          }
          {
            command =
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          }
          { command = "dbus-sway-environment"; }
          { command = "configure-gtk"; }
        ];

        assigns = {
          "2" = [{ app_id = "code"; }];
          "3" = [{ class = "firefox"; }];
          "4" = [{ class = "Thunderbird"; }];
          "8" = [
            { class = "Slack"; }
            { class = "discord"; }
            { app_id = "telegramdesktop"; }
          ];
          "9" = [{ class = "KeePassXC"; }];
        };

        floating.criteria = [
          { window_role = "pop-up"; }
          { window_role = "task_dialog"; }
          { app_id = "nz.co.mega."; }
        ];

        window.commands = [
          {
            criteria = { floating = true; };
            command = "border pixel 2";
          }
          {
            criteria = { workspace = "1"; };
            command = "layout stacking";
          }
          {
            criteria = { workspace = "2"; };
            command = "layout tabbed";
          }
          {
            criteria = { workspace = "3"; };
            command = "layout tabbed";
          }
          {
            criteria = { workspace = "8"; };
            command = "layout tabbed";
          }
          {
            criteria = { class = "firefox"; };
            command = "inhibit_idle fullscreen";
          }
          {
            criteria = { app_id = "pavucontrol"; };
            command =
              "floating enable, sticky enable, resize set width 550 px height 600px, move position cursor, move down 330";
          }
          {
            criteria = { class = "MEGAsync"; };
            command =
              "floating enable, move position center";
          }
          {
            criteria = { title = "Firefox — Sharing Indicator"; };
            command =
              "floating enable, no_focus, resize set 0 0, move absolute position 10 10";
          }
        ];

        keybindings = let
          modifier =
            config.home-manager.users.${userName}.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
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

          # Workspace 10
          "${modifier}+0" = "workspace number 10";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          # Moving workspaces between screens
          "${modifier}+Mod1+Up" = "move workspace to output up";
          "${modifier}+Mod1+Down" = "move workspace to output down";
          "${modifier}+Mod1+Left" = "move workspace to output left";
          "${modifier}+Mod1+Right" = "move workspace to output right";
        };
      };

      extraConfig = ''
        # Setting cursor theme
        seat seat0 xcursor_theme capitaine-cursors 16
        # Disable laptop screen on lid action
        bindswitch --reload --locked lid:on output eDP-1 disable
        bindswitch --reload --locked lid:off output eDP-1 enable
      '';
    };
  };
}
