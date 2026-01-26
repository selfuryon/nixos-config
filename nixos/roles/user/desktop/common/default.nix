{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    # ./dunst.nix  # disabled, using noctalia notifications
    # ./swaync.nix  # disabled, using noctalia notifications
    ./firefox.nix
    ./thunderbird.nix
    ./font.nix
    ./foot.nix
    ./gtk.nix
    ./ghostty.nix
    ./kitty.nix
    ./mpd.nix
    ./playerctl.nix
    ./qt.nix
    # ./hyprlock.nix
    ./hypridle.nix
    # ./hyprpaper.nix
    # ./waybar.nix  # disabled
    # ./ashell.nix  # disabled
    ./noctalia.nix
    ./wlsunset.nix
    ./fuzzel.nix
    ./wezterm.nix
  ];

  # programs.fish.loginShellInit = ''
  #   if test (tty) = /dev/tty1
  #     systemd-cat -t hyprland ${hyprland}
  #   end
  # '';
  # programs.nushell.loginFile.text = ''
  #   if (tty) == "/dev/tty3" {
  #     systemd-cat -t hyprland ${hyprland}
  #   }
  # '';

  home.activation."mimeapps-remove" = {
    before = [ "checkLinkTargets" ];
    after = [ ];
    data = "rm -f /home/syakovlev/.config/mimeapps.list";
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "firefox-beta.desktop" ];
        # "text/html" = [ "google-chrome.desktop" ];
        "x-scheme-handler/http" = [ "firefox-beta.desktop" ];
        "x-scheme-handler/https" = [ "firefox-beta.desktop" ];
        "image/*" = [ "firefox-beta.desktop" ];

        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "application/rar" = [ "org.gnome.FileRoller.desktop" ];
        "application/7z" = [ "org.gnome.FileRoller.desktop" ];
        "application/*tar" = [ "org.gnome.FileRoller.desktop" ];

        "inode/directory" = [ "thunar.desktop" ];
        "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
        "x-scheme-handler/matrix" = [ "element.desktop" ];
        "video/*" = [ "vlc.desktop" ];
        "application/pdf" = [ "org.kde.okular" ];

        "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
        "application/msword" = [ "writer.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
        "text/csv" = [ "calc.desktop" ];
      };
    };

    # desktopEntries = {
    #   megasync = {
    #     name = "Megasync (Wayland)";
    #     genericName = "File Synchronizer";
    #     exec = "megasync -platform xcb";
    #     icon = "mega";
    #     terminal = false;
    #     categories = [
    #       "Network"
    #       "System"
    #     ];
    #   };
    # };
  };

  home.packages = with pkgs; [
    adwaita-qt
    darkly-qt5
    google-chrome
    brave
    kdePackages.kwallet
    capitaine-cursors
    crosvm
    # zed-editor
    dconf
    # discord
    vesktop
    drawio
    framesh
    file-roller
    grim
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    joplin-desktop
    imv
    hoppscotch
    keepassxc
    libreoffice
    onlyoffice-desktopeditors
    ledger-live-desktop
    # megasync
    mpv
    zoom-us
    networkmanagerapplet
    kdePackages.okular
    pavucontrol
    qbittorrent
    #librewolf
    #qutebrowser
    slack
    slurp
    swappy
    telegram-desktop
    # tigervnc
    virt-manager
    virt-viewer
    vlc
    wf-recorder
    wireshark
    xdg-utils
    # pcmanfm-qt
    thunar
    kdePackages.dolphin
    thunar-media-tags-plugin
    xorg.xrdb
    xournalpp
    xwayland
    bruno
    #zotero
    wayland
    pciutils
    swaybg
    glib # gsettings
    qt6.qt5compat
    qt6.qtwayland
    wl-clipboard
    cliphist
  ];

  # home.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "Niri";
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_SESSION_DESKTOP = "Niri";

  #   QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  #   QT_QPA_PLATFORM = "wayland;xcb";
  #   QT_QPA_PLATFORMTHEME = "qt5ct";
  #   QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

  #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   GDK_BACKEND = "wayland,x11";
  #   GTK_USE_PORTAL = 1;
  # };
}
