{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "hicolor";
        package = pkgs.tela-icon-theme;
        size = "32x32";
      };
      settings = {
        global = {
          width = 400;
          height = 200;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#eceff1";
          font = "Inter 12";
        };

        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
    };
  };
}
