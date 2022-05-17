{
  # Lenovo E490
  jumo = {
    hostname = "jumo";
    system = "x86_64-linux";
    users = {
      "syakovlev" = {
        features = [ "cli" "sway-desktop" "music" "development" ];
        extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" "ssh" ];
      };
    };
  };

  # GE VPS
  v2d-hbastion = {
    hostname = "v2d-hbastion";
    system = "x86_64-linux";
    users = { "syakovlev" = { features = [ "cli" ]; }; };
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" "ssh" ];
  };

  # RU VPS 
  sb-hbastion = {
    hostname = "sb-hbastion";
    system = "x86_64-linux";
    users = { "syakovlev" = { features = [ "cli" ]; }; };
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" "ssh" ];
  };
}
