{
  # AM VPS
  hostname = "rn-hbastion";
  system = "x86_64-linux";
  sudo = "doas -u";
  sshUser = "syakovlev";
  users = ["syakovlev"];
}