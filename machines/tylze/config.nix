{
  # Beelink U59
  hostname = "tylze";
  system = "x86_64-linux";
  sudo = "doas -u";
  sshUser = "syakovlev";
  roles = [ "server" ];
  users = { "syakovlev" = { features = [ "cli" ]; }; };
}