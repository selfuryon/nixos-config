{ pkgs, config, ... }: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "hicolor";
      package = pkgs.tela-icon-theme;
      size = "32x32";
    };
    settings = with config.scheme.withHashtag; {
      global = {
        width = 600;
        height = 200;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = base05;
        separator_color = base05;
        font = "${config.themes.fontProfile.regular.family}";
      };

      # https://github.com/tinted-theming/base16-dunst
      urgency_low = {
        msg_urgency = "low";
        background = base01;
        foreground = base03;
        timeout = 10;
      };
      urgency_normal = {
        msg_urgency = "normal";
        background = base02;
        foreground = base05;
        timeout = 10;
      };
      urgency_critical = {
        msg_urgency = "critical";
        background = base08;
        foreground = base06;
        timeout = 10;
      };
    };
  };
}
