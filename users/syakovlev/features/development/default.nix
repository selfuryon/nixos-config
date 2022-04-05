{ config, lib, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ crosvm pijul rustup ];
}
