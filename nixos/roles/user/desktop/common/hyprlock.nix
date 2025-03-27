{
  programs.hyprlock = {
    enable = true;
    settings = {
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
    };
  };
}
