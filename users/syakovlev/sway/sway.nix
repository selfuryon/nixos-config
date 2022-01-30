{ config, lib, pkgs, ... }:

{ # ws1: terminal
  # ws2: code
  # ws3: browser
  # ws4: mail
  # ws5: files
  # ws6: media
  # ws7: editor
  # ws8: chat
  # ws9: secure
  # ws10: general

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND="1"
      export XDG_CURRENT_DESKTOP="sway"
      export XDG_SESSION_TYPE="sway"
    '';
    config = {
      bars = [{ command = "waybar"; }];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      modifier = "Mod4"; # Windows
      menu = "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wofi}/bin/wofi --show drun -i | ${pkgs.findutils}/bin/xargs swaymsg exec --";
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
          pointer_accel  = "0.7";
      };

      # Output configuration
      output."*" = { bg = "/home/syakovlev/Pictures/wife2.jpg fill"; };
      output."DP-1" = {
          mode = "3840x2160";
          pos  = "0,0";
      };

      output."eDP-1" = {
          mode = "1920x1080";
          pos  = "0,2160";
      };

      output."HDMI-A-1" = {
          mode = "1280x720";
          pos  = "1920,2160";
      };

      startup = [
        # Services
        { command = "wlsunset"; }
        { command = "mako"; }
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        { command = "sh ~/nixos-config/import_gsettings"; always = true; }
      ];

      assigns = {
        "2" = [{app_id = "code";}];
        "3" = [{class  = "firefox";}];
        "4" = [{class  = "Thunderbird";}];
        "8" = [{class  = "Slack";} {class = "discord";} {app_id = "telegramdesktop";}];
        "9" = [{class  = "KeePassXC";}];
      };

      floating.criteria = [
        { window_role ="pop-up"; }
        { window_role="task_dialog"; }
        { app_id="org.keepassxc.KeePassXC"; }
        { app_id="nz.co.mega."; }
      ];

      window.commands = [
        {criteria = { floating = true; };           command = "border pixel 2"; }
        {criteria = { workspace="3: browser"; };    command = "layout tabbed"; }
        {criteria = { workspace="8: chat"; };       command = "layout tabbed"; }
        {criteria = { class="firefox"; };           command = "inhibit_idle fullscreen"; }
        {criteria = { app_id="pavucontrol"; };      command = "floating enable, sticky enable, resize set width 550 px height 600px, move position cursor, move down 330"; }
      ];

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        # Control volume
        XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        XF86AudioMute        = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        XF86AudioMicMute     = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        # Control media
        #XF86AudioPlay  = "exec playerctl play-pause";
        #XF86AudioPause = "exec playerctl play-pause";
        #XF86AudioNext  = "exec playerctl next";
        #XF86AudioPrev  = "exec playerctl previous";

        # Control brightness
        XF86MonBrightnessUp   = "exec light -A 5";
        XF86MonBrightnessDown = "exec light -U 5";

        # Screenshots
        "print" = "exec grim -g \"\$(slurp)\" - | swappy -f -";
        "Shift+print" = "exec grim - | swappy -f -";

        # Focus
        "${modifier}+z"       = "focus child";

        # Lock
        "${modifier}+Shift+x" = "exec ${pkgs.swaylock}/bin/swaylock -f";

        # Workspace 10
        "${modifier}+0"       = "workspace number 10";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Moving workspaces between screens
        "${modifier}+Mod1+Up"    = "move workspace to output up";
        "${modifier}+Mod1+Down"  = "move workspace to output down";
        "${modifier}+Mod1+Left"  = "move workspace to output left";
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

  services.wlsunset = {
    enable = true;
    latitude = "55.7";
    longitude = "37.6";
  };

  services.swayidle = {
    enable = true;
    events = [{event = "before-sleep"; command = "swaylock -f";}];
    timeouts = [
      {timeout = 300; command = "swaylock -f";}
      {timeout = 600; command = "swaymsg \"output * dpms off\""; resumeCommand = "swaymsg \"output * dpms on \"";}
    ];
  };

  programs.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
  };

  gtk = {
    enable = true;
    gtk3.bookmarks = [ "file:///home/syakovlev/documents" "file:///home/syakovlev/mega" "file:///home/syakovlev/Downloads"];
    gtk3.extraConfig = {
      gtk-cursor-theme-name = "capitaine-cursors";
    };
    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
      size = 12;
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-light-alt-blue";
    };

  };

  home.packages = with pkgs; [
    grim
    slurp
    swappy
    qt5.qtwayland
    libsForQt5.lightly
    swaylock
    waybar
    wl-clipboard
    clipman
    wofi
    xwayland
    alacritty
    xdg-utils
    xorg.xrdb
    gsettings_desktop_schemas
    glib
    feh
    networkmanagerapplet
    adwaita-qt
    capitaine-cursors
    wf-recorder
    virt-manager
    virt-viewer
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
  ];

}

