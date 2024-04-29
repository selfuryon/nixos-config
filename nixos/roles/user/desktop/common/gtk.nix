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
    #   name = "Catppuccin-Latte";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = ["green"];
    #     variant = "latte";
    #   };
    # };
    # cursorTheme = {
    #   package = pkgs.capitaine-cursors;
    #   name = "capitaine-cursors";
    #   size = 16;
    # };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-light";
  };

  dconf.settings = {
    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Latte-Standard-Lavender-Light";
    };
  };
}
