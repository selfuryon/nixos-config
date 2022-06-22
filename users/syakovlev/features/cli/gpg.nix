{ config, pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    programs.gpg = {
      enable = true;
      homedir = "${config.home-manager.users.${userName}.xdg.dataHome}/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };

    home.packages = with pkgs; [ pinentry-gtk2 ];

  };
}
