{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.home.packages = with pkgs; [
    crosvm
    pijul
    rustup
  ];
}
