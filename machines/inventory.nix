{
  # Lenovo E490
  jumo = {
    hostname = "jumo";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    roles = [ "desktop" ];
    users = {
      "syakovlev" = {
        features = [ "cli" "sway-desktop" "music" "development" ];
      };
    };
  };

  # Beelink U59
  tylze = {
    hostname = "tylze";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    roles = [ "server" ];
    users = {
      "syakovlev" = {
        features = [ "cli" ];
      };
    };
  };

  # GE VPS
  v2d-hbastion = {
    hostname = "v2d-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    roles = [ "server" ];
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };

  # RU VPS 
  sb-hbastion = {
    hostname = "sb-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    roles = [ "server" ];
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };

  # AM VPS
  rn-hbastion = {
    hostname = "rn-hbastion";
    system = "x86_64-linux";
    sshUser = "syakovlev";
    roles = [ "server" ];
    users = { "syakovlev" = { features = [ "cli" ]; }; };
  };
}
