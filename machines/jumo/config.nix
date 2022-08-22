{
  # Lenovo E490
  hostname = "jumo";
  system = "x86_64-linux";
  sudo = "doas -u";
  sshUser = "syakovlev";
  roles = [ "desktop" ];
  users = {
    "syakovlev" = {
      features = [ "cli" "sway-desktop" "music" "development" ];
    };
  };
}
