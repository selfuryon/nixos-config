{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      #env.TERM = "xterm-256color";
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        normal.family = "${config.themes.fontProfile.monospace.family}";
        size = 13.0;
      };

      # Github Light Theme: https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-github-256.yml
      colors = {
        primary = {
          background = "0xffffff";
          foreground = "0x373b41";
        };
        cursor = {
          text = "0xffffff";
          cursor = "0x373b41";
        };
        normal = {
          black = "0xffffff";
          red = "0xcc342b";
          green = "0x198844";
          yellow = "0xfba922";
          blue = "0x3971ed";
          magenta = "0xa36ac7";
          cyan = "0x3971ed";
          white = "0x373b41";
        };
        bright = {
          black = "0xb4b7b4";
          red = "0xcc342b";
          green = "0x198844";
          yellow = "0xfba922";
          blue = "0x3971ed";
          magenta = "0xa36ac7";
          cyan = "0x3971ed";
          white = "0x1d1f21";
        };
        indexed_colors = [
          {
            index = 16;
            color = "0xf96a38";
          }
          {
            index = 17;
            color = "0x3971ed";
          }
          {
            index = 18;
            color = "0xe0e0e0";
          }
          {
            index = 19;
            color = "0xc5c8c6";
          }
          {
            index = 20;
            color = "0x969896";
          }
          {
            index = 21;
            color = "0x282a2e";
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
