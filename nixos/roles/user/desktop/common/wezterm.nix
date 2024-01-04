{config, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- https://github.com/wez/wezterm/issues/4483
      config.enable_wayland = false

      config.color_scheme = "Catppuccin Latte"

      config.font = wezterm.font "${config.themes.fontProfile.monospace.family}"
      config.font_size = 15.0

      -- config.harfbuzz_features = { 'calt', 'liga', 'dlig','ss01', 'ss02', 'ss03', 'ss06' }
      config.audible_bell = "Disabled"

      return config
    '';
  };
}
