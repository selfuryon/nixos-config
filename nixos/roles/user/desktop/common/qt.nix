{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "lightly";
      #package = pkgs.adwaita-qt;
      package = pkgs.libsForQt5.lightly;
    };
  };
}
