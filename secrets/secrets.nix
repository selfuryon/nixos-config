let
  default =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApR73ZS8Ujj9iR3n9kSCC2YftCLobFM1PPAghtQSSZz";
  tylze =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBO4P/ejs9x7SJGQk0juCggD84gQ71EJWy8//33vzxgI";
  rn-hbastion =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkFnFFJItyh08enEtxw6hQRh8wOCaxdyeL0vf7k0PBd";
  sb-hbastion =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIsak8JhPgjhuMIDBSFDkj3D4LuMuEDimTwO9ElPFGWx";
  v2d-hbastion =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXaHVAMdx4361jQrs5tN7mi+yBdLDPB+ifeRHAsXJVd";
in {
  "wireless.cyhome.age".publicKeys = [ tylze default ];
  "wireguard.rn-hbastion.age".publicKeys = [ rn-hbastion default ];
  "wireguard.sb-hbastion.age".publicKeys = [ sb-hbastion default ];
  "wireguard.v2d-hbastion.age".publicKeys = [ v2d-hbastion default ];
}
