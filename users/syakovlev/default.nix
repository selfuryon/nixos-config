{ features, lib, ... }: {
  imports = lib.forEach features (f: ./features + "/${f}");

  programs.home-manager.enable = true;
  home.stateVersion = "22.05"
}
