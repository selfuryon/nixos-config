{ pkgs, ... }: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///home/syakovlev/documents"
      "file:///home/syakovlev/mega"
      "file:///home/syakovlev/Downloads"
    ];
    gtk3.extraConfig = { gtk-cursor-theme-name = "capitaine-cursors"; };
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
  };
}
