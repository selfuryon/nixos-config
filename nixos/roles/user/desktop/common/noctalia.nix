{
  inputs,
  pkgs,
  config,
  ...
}:
let
  noctaliaSettings = config.programs.noctalia-shell.settings;
  noctaliaColors = config.programs.noctalia-shell.colors;
in
{
  home.packages = [ inputs.noctalia.packages.${pkgs.system}.default ];

  systemd.user.services.noctalia-shell = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.noctalia-shell.Unit.X-Restart-Triggers = [
    (builtins.hashString "sha256" (builtins.toJSON noctaliaSettings))
    (builtins.hashString "sha256" (builtins.toJSON noctaliaColors))
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      appLauncher = {
        iconMode = "tabler";
        position = "center";
        showCategories = true;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        viewMode = "list";
        enableClipboardHistory = true;
        enableSettingsSearch = true;
      };

      audio = {
        volumeStep = 5;
        volumeFeedback = false;
      };

      bar = {
        backgroundOpacity = 0.93;
        density = "default";
        exclusive = true;
        floating = false;
        marginHorizontal = 4;
        marginVertical = 4;
        outerCorners = true;
        position = "top";
        showCapsule = false;
        showOutline = false;
        widgets = {
          left = [
            {
              id = "Launcher";
              icon = "rocket";
              usePrimaryColor = false;
            }
            {
              id = "ActiveWindow";
              showIcon = true;
              maxWidth = 450;
              hideMode = "hidden";
              scrollingMode = "hover";
              colorizeIcons = false;
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
              showApplications = false;
              iconScale = 0.8;
              enableScrollWheel = true;
            }
          ];
          right = [
            {
              id = "SystemMonitor";
              compactMode = true;
              showCpuUsage = true;
              showCpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = false;
              showDiskUsage = false;
              showNetworkStats = false;
              useMonospaceFont = true;
              usePrimaryColor = false;
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              maxWidth = 145;
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              scrollingMode = "hover";
            }
            {
              id = "Tray";
              drawerEnabled = true;
              colorizeIcons = false;
            }
            {
              id = "Network";
              displayMode = "onhover";
            }
            {
              id = "Bluetooth";
              displayMode = "onhover";
            }
            {
              id = "Volume";
              displayMode = "onhover";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              id = "Brightness";
              displayMode = "onhover";
            }
            {
              id = "Battery";
              displayMode = "onhover";
              hideIfNotDetected = true;
              warningThreshold = 30;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              hideWhenZero = false;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm - dd MM";
              tooltipFormat = "HH:mm ddd, MMM dd";
              usePrimaryColor = true;
            }
            {
              id = "plugin:tailscale";
            }
          ];
        };
      };

      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
      };

      colorSchemes = {
        darkMode = false;
        predefinedScheme = "Nord";
        schedulingMode = "off";
        useWallpaperColors = false;
      };

      general = {
        avatarImage = "/home/syakovlev/Pictures/fireman.png";
        radiusRatio = 0.2;
        boxRadiusRatio = 1;
        iRadiusRatio = 1;
        scaleRatio = 1;
        enableShadows = true;
        shadowDirection = "bottom_right";
        dimmerOpacity = 0.2;
        animationSpeed = 1;
        telemetryEnabled = false;
      };

      location = {
        name = "Paphos, Cyprus";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showCalendarWeather = true;
        firstDayOfWeek = -1;
      };

      nightLight = {
        enabled = true;
        autoSchedule = true;
        dayTemp = "6500";
        nightTemp = "4000";
      };

      notifications = {
        enabled = true;
        location = "top_right";
        overlayLayer = true;
        enableKeyboardLayoutToast = false;
        enableMediaToast = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
      };

      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
      };

      ui = {
        fontDefault = "Noto Sans";
        fontFixed = "Input Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        panelBackgroundOpacity = 0.93;
        panelsAttachedToBar = true;
        tooltipsEnabled = true;
      };

      wallpaper = {
        enabled = true;
        directory = "/home/syakovlev/Pictures/Wallpapers";
        fillMode = "crop";
        transitionType = "random";
        transitionDuration = 1500;
        setWallpaperOnAllMonitors = true;
      };
    };

    # Nord palette
    colors = {
      mPrimary = "#5e81ac";
      mOnPrimary = "#eceff4";
      mSecondary = "#64adc2";
      mOnSecondary = "#eceff4";
      mTertiary = "#6fa9a8";
      mOnTertiary = "#eceff4";
      mError = "#bf616a";
      mOnError = "#eceff4";
      mSurface = "#eceff4";
      mOnSurface = "#2e3440";
      mHover = "#6fa9a8";
      mOnHover = "#eceff4";
      mSurfaceVariant = "#e5e9f0";
      mOnSurfaceVariant = "#4c566a";
      mOutline = "#c5cedd";
      mShadow = "#d8dee9";
    };
  };
}
