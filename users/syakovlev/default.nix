{ config, lib, pkgs, ... }: {
  imports = [ ./cli ./sway-desktop ];
  programs.home-manager.enable = true;
}
