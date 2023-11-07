{config, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = "Catppuccin Latte";
      config.font = wezterm.font "${config.themes.fontProfile.monospace.family}"
      config.font_size = 15.0;
      return config
    '';
  };
}
