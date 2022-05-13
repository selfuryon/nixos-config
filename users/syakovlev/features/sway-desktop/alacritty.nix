{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 13.0;
      };

      # Guthub light theme
      colors = {
        primary = {
          background = "0xffffff";
          foreground = "0x24292f";
        };
        normal = {
          black = "0x24292e";
          red = "0xd73a49";
          green = "0x28a745";
          yellow = "0xdbab09";
          blue = "0x0366d6";
          magenta = "0x5a32a3";
          cyan = "0x0598bc";
          white = "0x6a737d";
        };
        bright = {
          black = "0x959da5";
          red = "0xcb2431";
          green = "0x22863a";
          yellow = "0xb08800";
          blue = "0x005cc5";
          magenta = "0x5a32a3";
          cyan = "0x3192aa";
          white = "0xd1d5da";
        };
        indexed_colors = [
          {
            index = 16;
            color = "0xd18616";
          }
          {
            index = 17;
            color = "0xcb2431";
          }
        ];
      };

      selection.save_to_clipboard = true;
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };
}
