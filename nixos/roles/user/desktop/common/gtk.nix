{pkgs, ...}: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///home/syakovlev/documents"
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
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Light";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 16;
    };
  };
}
