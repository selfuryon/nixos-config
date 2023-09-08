{pkgs, ...}: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///home/syakovlev/Documents"
      "file:///home/syakovlev/mega"
      "file:///home/syakovlev/Downloads"
    ];
    font = {
      package = pkgs.noto-fonts;
      name = "Inter";
      size = 12;
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };
    # theme = {
    #   package = pkgs.orchis-theme;
    #   name = "Orchis-Light";
    # };
    theme = {
      name = "Catppuccin-Latte";
      package = pkgs.catppuccin-gtk.override {
        accents = ["green"];
        variant = "latte";
      };
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 16;
    };
  };
}
