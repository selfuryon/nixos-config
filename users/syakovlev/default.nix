{ config, lib, pkgs, ... }: {
  imports = [
    ./cli
    ./sway
  ];
  programs.home-manager.enable = true;

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
  ]; 
}
