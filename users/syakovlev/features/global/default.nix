{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules
    ./cli
    ./nvim
  ];
}
