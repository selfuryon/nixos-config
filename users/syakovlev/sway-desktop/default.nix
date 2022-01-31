{ config, lib, pkgs, ... }: {
  imports = [
    ./alacritty.nix
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

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ 
    keepassxc
    firefox-wayland
    brave
    thunderbird
    slack
    discord
    skype
    tdesktop
    okular
    xfce.thunar
    xfce.thunar-media-tags-plugin
    vlc
    xarchiver
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
