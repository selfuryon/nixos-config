let
  credentials = import ./_credentials.nix;
in
{
  flake.modules.nixos.root.users.users.root = {
    inherit (credentials) hashedPassword;
    openssh.authorizedKeys.keys = credentials.authorizedKeys;
  };
}
