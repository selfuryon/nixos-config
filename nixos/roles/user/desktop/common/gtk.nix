{pkgs, ...}: {
  home.pointerCursor = {
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    gtk.enable = true;
    size = 16;
  };

  gtk = {
    enable = true;
    #catppuccin.enable = true;
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
      #package = pkgs.tela-icon-theme;
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-light";
    };
    theme = {
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme.override {
        colorVariants = ["Light"];
      };
    };
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
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
