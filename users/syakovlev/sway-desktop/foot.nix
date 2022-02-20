{ config, lib, pkgs, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=13";
        dpi-aware = "yes";
      };
      scrollback = { lines = 10000; };
      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
