{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.programs.mako = {
    enable = true;
    font = "Inter 12";
  };
}
