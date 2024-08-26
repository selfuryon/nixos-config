let
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApR73ZS8Ujj9iR3n9kSCC2YftCLobFM1PPAghtQSSZz";
  tylze = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBO4P/ejs9x7SJGQk0juCggD84gQ71EJWy8//33vzxgI";
in {
  "wireless.cyhome.age".publicKeys = [tylze default];
}
