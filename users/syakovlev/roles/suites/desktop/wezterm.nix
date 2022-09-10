{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'

        return {
          color_scheme = "Github",
          font = wezterm.font('JetBrains Mono'),
          font_size = 13.0,
          unix_domains = {
            { name = 'unix', },
          },
        }
      '';

    };
  };
}
