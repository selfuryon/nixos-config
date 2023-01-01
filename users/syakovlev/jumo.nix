{ inputs, hostname, pkgs, lib, ... }:
let
  userName = "syakovlev";
in {
  imports = [
   ./features/desktop/hyprland
  ];

}
