{config, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      inherit (config.themes.fontProfile.monospace) package;
      name = "family=\"${config.themes.fontProfile.monospace.family}\" features=\"+ss12\"";
      size = 15;
    };
    #theme = "Catppuccin-Latte";
    settings = {
      enable_audio_bell = false;
      term = "xterm-256color";
      copy_on_select = true;
      hide_window_decorations = true;
      window_margin_width = 6;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "shift+insert" = "paste_from_clipboard";
    };
  };
}
