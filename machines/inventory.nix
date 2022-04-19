{
  # Lenovo E490
  jumo = {
    hostname = "jumo";
    system = "x86_64-linux";
    users = { "syakovlev" = [ "cli" "sway-desktop" "music" "development" ]; };
  };

  # GE VPS
  v2d-hbastion = {
    hostname = "v2d-hbastion";
    system = "x86_64-linux";
    users = { "syakovlev" = [ "cli" ]; };
  };

  # RU VPS 
  sb-hbastion = {
    hostname = "sb-hbastion";
    system = "x86_64-linux";
    users = { "syakovlev" = [ "cli" ]; };
  };
}
