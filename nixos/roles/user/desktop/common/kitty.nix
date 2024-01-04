{config, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      inherit (config.themes.fontProfile.monospace) package;
      name = config.themes.fontProfile.monospace.family;
      size = 15;
    };
    theme = "Catppuccin-Latte";
    settings = {
      enable_audio_bell = false;
      term = "xterm-256color";
      copy_on_select = true;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "shift+insert" = "paste_from_clipboard";
    };
  };
}
