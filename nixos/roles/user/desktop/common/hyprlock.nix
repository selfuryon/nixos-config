{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = with config.scheme; {
      general = {
        #grace = 5;
        hide_cursor = true;
      };
      background = [
        {
          #path = "/home/syakovlev/Pictures/lock.jpg";
          path = "/home/syakovlev/Pictures/wallpapers/sunset-lookout.jpg";
          #blur_passes = 3;
          #blur_size = 8;
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          #fade_on_empty = false;
          font_color = "rgb(${base05})";
          inner_color = "rgb(${base00})";
          outer_color = "rgb(${base07})";
          outline_thickness = 5;
          #placeholder_text = "<i>Input Password...</i>";
          shadow_passes = 2;
        }
      ];
    };
  };
}
