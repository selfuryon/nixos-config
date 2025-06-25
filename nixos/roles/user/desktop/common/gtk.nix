{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
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
      "file:///home/syakovlev/Documents"
      "file:///home/syakovlev/cloud"
      "file:///home/syakovlev/Downloads"
    ];
    font = {
      package = pkgs.noto-fonts;
      name = config.themes.fontProfile.regular.family;
      size = 12;
    };
    iconTheme = {
      #package = pkgs.tela-circle-icon-theme;
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Light";
    };
    theme = {
      name = "Arc-Lighter";
      package = pkgs.arc-theme;
      # package = pkgs.orchis-theme.override {
      #   colorVariants = ["light"];
      # };
    };
    cursorTheme = {
      name = "catppuccin-latte-dark-cursors";
      package = pkgs.catppuccin-cursors.latteDark;
      size = 16;
    };
  };

  # dconf.settings."org/gnome/desktop/interface" = {
  #   name = "Catppuccin-Latte-Standard-Lavender-light";
  #   color-scheme = "prefer-light";
  # };

  # dconf.settings = {
  #   # For Gnome shell
  #   "org/gnome/shell/extensions/user-theme" = {
  #     name = "Catppuccin-Latte-Standard-Lavender-light";
  #   };
  # };
}
