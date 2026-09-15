{ pkgs, ... }:
let
  # One derivation, referenced twice: as the theme file in ~/.config and as an
  # absolute customThemeFile. The greeter resolves customThemeFile itself with
  # plain `[ -f ]`, which cannot expand a leading "~", so the path must be real.
  catppuccinLatteTheme = (pkgs.formats.json { }).generate "catppuccin-latte.json" {
    light = {
      primary = "#1e66f5";
      primaryText = "#eff1f5";
      primaryContainer = "#bcc0cc";
      secondary = "#209fb5";
      surfaceTint = "#1e66f5";
      surface = "#eff1f5";
      surfaceText = "#4c4f69";
      surfaceVariant = "#e6e9ef";
      surfaceVariantText = "#6c6f85";
      surfaceContainer = "#e6e9ef";
      surfaceContainerHigh = "#dce0e8";
      surfaceContainerHighest = "#ccd0da";
      background = "#eff1f5";
      backgroundText = "#4c4f69";
      outline = "#9ca0b0";
      error = "#d20f39";
      warning = "#df8e1d";
      info = "#1e66f5";
    };
  };
in
{
  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = false;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;
    niri = {
      enableKeybinds = true;
      enableSpawn = false;
      includes.enable = false;
    };

    session = {
      isLightMode = true;
      latitude = 34.7754;
      longitude = 32.4244;
      weatherLocation = "Paphos, Cyprus";
      weatherCoordinates = "34.7754,32.4244";
      wallpaperPath = "/home/syakovlev/Pictures/Wallpapers/explorer-robot.png";
    };
    settings = {
      currentThemeName = "custom";
      customThemeFile = "${catppuccinLatteTheme}";

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          leftWidgets = [
            "launcherButton"
            "focusedWindow"
          ];
          centerWidgets = [ "workspaceSwitcher" ];
          rightWidgets = [
            "cpuUsage"
            "memUsage"
            "music"
            "systemTray"
            "notificationButton"
            "battery"
            "clock"
            "controlCenterButton"
          ];
          transparency = 0.93;
          spacing = 4;
          innerPadding = 4;
        }
      ];

      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowBrightnessIcon = true;

      showCpuUsage = true;
      showCpuTemp = true;
      showMemUsage = true;
      showGpuTemp = false;

      use24HourClock = true;
      showSeconds = false;

      showWorkspaceApps = false;
      showOccupiedWorkspacesOnly = false;

      fontFamily = "Noto Sans";
      monoFontFamily = "Input Mono";

      gtkThemingEnabled = false;
      qtThemingEnabled = false;

      osdMediaPlaybackEnabled = false;

      spotlightCloseNiriOverview = true;
      niriOverviewOverlayEnabled = true;
      syncModeWithPortal = true;

      notificationTimeoutLow = 3000;
      notificationTimeoutNormal = 8000;
      notificationTimeoutCritical = 15000;
    };
  };

  xdg.configFile."DankMaterialShell/themes/catppuccin-latte.json".source = catppuccinLatteTheme;

}
