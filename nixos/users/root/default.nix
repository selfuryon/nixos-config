let
  shared = import ../shared.nix;
in
{
  users.users.root = {
    inherit (shared) hashedPassword;
    openssh.authorizedKeys.keys = shared.authorizedKeys;
  };
}
