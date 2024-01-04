{
  config,
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.packages = with pkgs; [pinentry-gtk2];
}
