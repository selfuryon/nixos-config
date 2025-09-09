{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    #kvantumThemePackage
    # libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    lxqt.lxqt-menu-data
    shared-mime-info
    pcmanfm-qt
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
    # "Kvantum/Arc".source = "${pkgs.arc-kde-theme}/share/Kvantum/Arc";
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvArc
    '';

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Zafiro-icons-Light";
        };
      };
    };

    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Zafiro-icons-Light";
        };
      };
    };
  };
}
