{
  pkgs,
  config,
  ...
}:
{
  home.pointerCursor = {
    enable = true;
    # name = "Babita-Modern-Classic";
    # package = pkgs.bibata-cursors;
    name = "catppuccin-latte-dark-cursors";
    package = pkgs.catppuccin-cursors.latteBlue;
    gtk.enable = true;
    x11.enable = true;
    size = 16;
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = false;
    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/Documents"
      "file://${config.home.homeDirectory}/cloud"
      "file://${config.home.homeDirectory}/Downloads"
    ];
    font = {
      package = pkgs.noto-fonts;
      name = config.themes.fontProfile.regular.family;
      size = 12;
    };
    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Light";
    };
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "catppuccin-latte-dark-cursors";
      package = pkgs.catppuccin-cursors.latteDark;
      size = 16;
    };
  };

}
