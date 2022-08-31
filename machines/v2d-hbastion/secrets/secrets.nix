let
  v2d-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXaHVAMdx4361jQrs5tN7mi+yBdLDPB+ifeRHAsXJVd";
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApR73ZS8Ujj9iR3n9kSCC2YftCLobFM1PPAghtQSSZz";
in
{
  "wireguard.age".publicKeys = [ v2d-hbastion default ];
}
