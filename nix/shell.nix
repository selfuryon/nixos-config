{
  perSystem = {
    pkgs,
    config,
    self',
    inputs',
    ...
  }: let
    inherit (pkgs) mkShellNoCC;
    inherit (inputs'.ragenix.packages) ragenix;
    inherit (inputs'.colmena.packages) colmena;
    inherit (pkgs) statix;
  in {
    devShells.default = mkShellNoCC {
      name = "etherno-iac";
      inputsFrom = [
        config.flake-root.devShell
        config.mission-control.devShell
        #config.pre-commit.devShell
      ];
      packages = [ragenix statix colmena];
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
