{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    qt = {
      enable = true;
      platformTheme = "gtk";
    };
  };
}
