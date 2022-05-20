{ inputs, users, ... }:
let
  userList = builtins.attrNames users;
  lib = inputs.nixpkgs.lib;
in { imports = lib.forEach userList (f: ./${f}); }
