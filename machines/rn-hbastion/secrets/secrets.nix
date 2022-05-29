let
  rn-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkFnFFJItyh08enEtxw6hQRh8wOCaxdyeL0vf7k0PBd";
in
{
  "wireguard.age".publicKeys = [ rn-hbastion ];
}
