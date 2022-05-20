{ pkgs, ... }: { home.packages = with pkgs; [ crosvm pijul rustup ]; }
