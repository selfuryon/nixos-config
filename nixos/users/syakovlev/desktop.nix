{ inputs, roles, ... }:
let
  userName = "syakovlev";
in
{
  home-manager.users.${userName} = {
    imports = [
      roles.user.desktop.niri.default
      inputs.noctalia.homeModules.default
    ];
  };
}
