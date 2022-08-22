{
  # GE VPS
  hostname = "v2d-hbastion";
  system = "x86_64-linux";
  sudo = "doas -u";
  sshUser = "syakovlev";
  roles = [ "server" ];
  users = { "syakovlev" = { features = [ "cli" ]; }; };
}
