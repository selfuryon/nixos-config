lib: rec {
  createInventory = let
    inventoryDirs = dir:
      builtins.attrNames (lib.filterAttrs (name: type:
        type == "directory"
        && builtins.pathExists (dir + "/${name}/config.nix"))
        (builtins.readDir dir));
  in dir: lib.genAttrs (inventoryDirs dir) (name: import (dir + "/${name}/config.nix"));
}
