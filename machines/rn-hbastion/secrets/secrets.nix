let
  rn-hbastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkFnFFJItyh08enEtxw6hQRh8wOCaxdyeL0vf7k0PBd";
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApR73ZS8Ujj9iR3n9kSCC2YftCLobFM1PPAghtQSSZz";
in
{
  "wireguard.age".publicKeys = [ rn-hbastion default ];
}
