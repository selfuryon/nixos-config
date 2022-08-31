let
  sb-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIsak8JhPgjhuMIDBSFDkj3D4LuMuEDimTwO9ElPFGWx";
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApR73ZS8Ujj9iR3n9kSCC2YftCLobFM1PPAghtQSSZz";
in
{
  "wireguard.age".publicKeys = [ sb-hbastion default ];
}
