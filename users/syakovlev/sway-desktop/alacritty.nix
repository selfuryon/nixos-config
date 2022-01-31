{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
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
        primary= {
          background = "0xffffff";
          foreground = "0x586069";
        };
        normal = {
          black   = "0x697179";
          red     = "0xd03d3d";
          green   = "0x14ce14";
          yellow  = "0x949800";
          blue    = "0x0451a5";
          magenta = "0xbc05bc";
          cyan    = "0x0598bc";
        };
        bright = {
          black   = "0x666666";
          red     = "0xcd3131";
          green   = "0x14ce14";
          yellow  = "0xb5ba00";
          blue    = "0x0451a5";
          magenta = "0xbc05bc";
          cyan    = "0x0598bc";
          white   = "0x586069";
        };
        indexed_colors = [
          { index = 16; color = "0xd18616"; }
          { index = 17; color = "0xcd3131"; }
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
