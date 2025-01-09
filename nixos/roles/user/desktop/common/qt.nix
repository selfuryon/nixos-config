{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    #kvantumThemePackage
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    lxqt.lxqt-menu-data
    shared-mime-info
    pcmanfm-qt
    arc-kde-theme
  ];
  catppuccin.kvantum.enable = false;
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style = {
      name = "kvantum";
      package = pkgs.arc-kde-theme;
    };
  };
  xdg.configFile = {
    "Kvantum/Arc".source = "${pkgs.arc-kde-theme}/share/Kvantum/Arc";
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Arc
    '';

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI {} {
        Appearance = {
          icon_theme = "Tela-circle";
        };
      };
    };

    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI {} {
        Appearance = {
          icon_theme = "Tela-circle";
        };
      };
    };
  };
}
