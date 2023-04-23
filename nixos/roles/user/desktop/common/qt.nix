{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "lightly";
      #package = pkgs.adwaita-qt;
      package = pkgs.libsForQt5.lightly;
    };
  };
}
