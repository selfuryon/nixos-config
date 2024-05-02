{pkgs, ...}: {
  home.pointerCursor = {
    name = "Catppuccin-Latte-Lavender-Cursors";
    package = pkgs.catppuccin-cursors.latteLavender;
    gtk.enable = true;
    size = 16;
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = false;
    gtk3.bookmarks = [
      "file:///home/syakovlev/Documents"
      "file:///home/syakovlev/mega"
      "file:///home/syakovlev/Downloads"
    ];
    font = {
      package = pkgs.noto-fonts;
      #name = config.themes.fontProfile.regular.family;
      name = "Inter";
      size = 12;
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };
    # theme = {
    #   name = "Catppuccin-Latte-Standard-Lavender-light";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = ["lavender"];
    #     size = "standard";
    #     variant = "latte";
    #   };
    # };
    # cursorTheme = {
    # name = "Catppuccin-Latte-Lavender-Cursors";
    # package = pkgs.catppuccin-cursors.latteLavender;
    # size = 16;
    # };
  };

  # dconf.settings."org/gnome/desktop/interface" = {
  #   name = "Catppuccin-Latte-Standard-Lavender-light";
  #   color-scheme = "prefer-light";
  # };

  dconf.settings = {
    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Latte-Standard-Lavender-light";
    };
  };
}
