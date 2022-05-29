let
  sb-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIsak8JhPgjhuMIDBSFDkj3D4LuMuEDimTwO9ElPFGWx";
in
{
  "wireguard.age".publicKeys = [ sb-hbastion ];
}
