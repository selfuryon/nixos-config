lib:
let
  inventory = import ./inventory.nix lib;
  fs = import ./fs.nix lib;
in
{
  inherit inventory fs;
}
