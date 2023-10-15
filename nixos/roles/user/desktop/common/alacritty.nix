{
  inputs,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = ["${inputs.catppuccin-alacritty}/catppuccin-latte.yml"];
      env.TERM = "xterm-256color";
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        normal.family = "${config.themes.fontProfile.monospace.family}";
        size = 15.0;
      };

      selection.save_to_clipboard = true;
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };
}
