{
  pkgs,
  config,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        font = "${config.themes.fontProfile.regular.family}:size=18";
        dpi-aware = false;
        icon-theme = "WhiteSur-light";
        icon-enabled = true;
      };
    };
  };
}
