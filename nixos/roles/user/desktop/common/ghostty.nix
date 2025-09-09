{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
      font-family = config.themes.fontProfile.monospace.family;
      font-size = 15;
      confirm-close-surface = false;
      window-decoration = false;
    };
  };
}
