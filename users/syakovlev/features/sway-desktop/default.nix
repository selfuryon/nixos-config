{ pkgs, ... }:
let userName = "syakovlev";
in {
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./foot.nix
    #./gsettings.nix
    ./gtk.nix
    ./mako.nix
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
    ./wlsunset.nix
  ];

  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  services = {
    dbus.packages = [ pkgs.gcr ];
  };

  programs = {
    ssh.startAgent = true;
    firejail.enable = true;
    light.enable = true;
  };

  qt5.platformTheme = "qt5ct";

  home-manager.users.${userName} = {
    xdg.mimeApps.defaultApplications = {
      browser = {
        cmd = "${pkgs.firefox-wayland}/bin/firefox";
        desktop = "firefox";
      };
    };
    xdg.desktopEntries = {
      megasync = {
        name = "Megasync (Wayland)";
        genericName = "File Synchronizer";
        exec = "megasync -platform xcb";
        icon = "mega";
        terminal = false;
        categories = [ "Network" "System" ];
      };
    };

    home.packages = with pkgs; [
      tigervnc
      keepassxc
      brave
      thunderbird
      slack
      discord
      pavucontrol
      skypeforlinux
      tdesktop
      okular
      xfce.thunar
      xfce.thunar-media-tags-plugin
      vlc
      xarchiver
      mpv
      qutebrowser
      libreoffice
      grim
      slurp
      swappy
      qt5.qtwayland
      libsForQt5.lightly
      wl-clipboard
      clipman
      xwayland
      xdg-utils
      xorg.xrdb
      feh
      networkmanagerapplet
      adwaita-qt
      capitaine-cursors
      wf-recorder
      virt-manager
      virt-viewer
      gtk-engine-murrine
      gtk_engines
      dconf
      gsettings-desktop-schemas
      lxappearance
      megasync
      qbittorrent
      wireshark
      fractal
      xournal
    ];
  };
}
