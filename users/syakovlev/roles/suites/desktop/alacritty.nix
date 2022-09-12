{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
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

        # Github Light Theme: https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-github-256.yml
        colors = {
          primary = {
            background = "0xffffff";
            foreground = "0x333333";
          };
          cursor = {
            text = "0xffffff";
            cursor = "0x333333";
          };
          normal = {
            black = "0xffffff";
            red = "0xed6a43";
            green = "0x183691";
            yellow = "0x795da3";
            blue = "0x795da3";
            magenta = "0xa71d5d";
            cyan = "0x183691";
            white = "0x333333";
          };
          bright = {
            black = "0x969896";
            red = "0xed6a43";
            green = "0x183691";
            yellow = "0x795da3";
            blue = "0x795da3";
            magenta = "0xa71d5d";
            cyan = "0x183691";
            white = "0xffffff";
          };
          indexed_colors = [
            {
              index = 16;
              color = "0x0086b3";
            }
            {
              index = 17;
              color = "0x333333";
            }
            {
              index = 18;
              color = "0xf5f5f5";
            }
            {
              index = 19;
              color = "0xc8c8fa";
            }
            {
              index = 20;
              color = "0xe8e8e8";
            }
            {
              index = 21;
              color = "0xffffff";
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
  };
}
