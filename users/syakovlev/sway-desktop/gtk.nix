{ config, lib, pkgs, ... }: {
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
      name = "Noto Sans";
      size = 12;
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-light-alt-blue";
    };
  };
}
