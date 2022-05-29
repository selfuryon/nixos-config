let
  v2d-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXaHVAMdx4361jQrs5tN7mi+yBdLDPB+ifeRHAsXJVd";
in
{
  "wireguard.age".publicKeys = [ v2d-hbastion ];
}
