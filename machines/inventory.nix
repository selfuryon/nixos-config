{
  # Lenovo E490
  jumo = {
    hostname = "jumo";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    users = {
      "syakovlev" = {
        features = [ "cli" "sway-desktop" "music" "development" ];
      };
    };
  };

  # GE VPS
  v2d-hbastion = {
    hostname = "v2d-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };

  # RU VPS 
  sb-hbastion = {
    hostname = "sb-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };

  # AM VPS
  rn-hbastion = {
    hostname = "rn-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };
}
