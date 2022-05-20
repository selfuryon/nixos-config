{ config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  home.packages = with pkgs; [ pinentry-gtk2 ];
}
