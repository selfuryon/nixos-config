{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.devshell.flakeModule
    ./formatter.nix
    ./pre-commit.nix
    ./shell.nix
    ./tools.nix
  ];
}
