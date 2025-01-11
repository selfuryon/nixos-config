{roles, ...}: let
  userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    imports = [
      roles.user.desktop.hyprland.default
      roles.user.desktop.niri.default
    ];
  };
}
