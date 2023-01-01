{ inputs, pkgs, ... }:
let userName = "syakovlev";
in { imports = [ ./cli ./nvim ]; }
