{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.programs.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
  };
}
