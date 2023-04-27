{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.flake-root.flakeModule
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    ./checks.nix
    ./formatter.nix
    ./shell.nix
  ];
}
