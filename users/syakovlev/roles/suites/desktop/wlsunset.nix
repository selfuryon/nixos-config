{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.services.wlsunset = {
    enable = true;
    latitude = "55.7";
    longitude = "37.6";
  };
}
