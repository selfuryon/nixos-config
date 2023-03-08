lib: {
  createInventory = let
    inherit (builtins) attrNames pathExists readDir;
    inherit (lib) filterAttrs genAttrs;
    inventoryDirs = dir: attrNames (filterAttrs (name: type: type == "directory" && pathExists (dir + /${name}/config.nix)) (readDir dir));
  in
    dir: genAttrs (inventoryDirs dir) (name: import (dir + /${name}/config.nix));
}
