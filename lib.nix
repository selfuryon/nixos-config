lib: rec {
  findRoles = let
    mapAttrs' = lib.attrsets.mapAttrs';
    nameValuePair = lib.attrsets.nameValuePair;
    regularFiles = dir:
      lib.filterAttrs (name: type: type == "regular") (builtins.readDir dir);
    extractName = name: builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
  in dir:
  mapAttrs' (name: value: nameValuePair (extractName name) (dir + "/${name}"))
  (regularFiles dir);

  findModules = dir:
    builtins.concatLists (builtins.attrValues (builtins.mapAttrs (name: type:
      if type == "regular" then [{
        name = builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
        value = dir + "/${name}";
      }] else if (builtins.readDir (dir + "/${name}")) ? "default.nix" then [{
        inherit name;
        value = dir + "/${name}";
      }] else
        findModules (dir + "/${name}")) (builtins.readDir dir)));
}
