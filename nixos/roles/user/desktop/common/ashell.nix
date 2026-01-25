{
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Top";
      layer = "Top";

      modules = {
        left = [ "Workspaces" ];
        center = [ "WindowTitle" ];
        right = [
          [
            "SystemInfo"
            "Tray"
            "MediaPlayer"
            "Settings"
            "Clock"
          ]
        ];
      };

      appearance = {
        style = "Solid";
        opacity = 0.95;
        font_name = "JetBrains Mono";
        scale_factor = 1.0;

        # Catppuccin Latte palette
        primary_color = "#1e66f5"; # Blue
        text_color = "#4c4f69";
        background_color = "#eff1f5"; # Base
        secondary_color = "#ccd0da"; # Surface0
        success_color = "#40a02b"; # Green
        danger_color = "#d20f39"; # Red
      };

    };
  };
}
