{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      #preload = ["/home/syakovlev/Pictures/wife2.jpg"];
      #wallpaper = [",/home/syakovlev/Pictures/wife2.jpg"];
      preload = [ "/home/syakovlev/Pictures/wallpapers/watchtower-mountains-and-forests.jpg" ];
      wallpaper = [
        "eDP-1,/home/syakovlev/Pictures/wallpapers/watchtower-mountains-and-forests.jpg"
        "HDMI-A-1,/home/syakovlev/Pictures/wallpapers/watchtower-mountains-and-forests.jpg"
      ];
    };
  };
}
