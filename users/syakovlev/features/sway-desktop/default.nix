{ config, lib, pkgs, ... }: {
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

  xdg.mimeApps.defaultApplications = { };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "megasync" ];
  home.packages = with pkgs; [
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
    librewolf
    mpv
    qutebrowser
    libreoffice
    grim
    slurp
    swappy
    qt5.qtwayland
    libsForQt5.lightly
    swaylock
    wl-clipboard
    clipman
    xwayland
    xdg-utils
    xorg.xrdb
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
    dconf
    gsettings-desktop-schemas
    lxappearance
    megasync
    qbittorrent
    wireshark
    fractal
    xournal
  ];
}
