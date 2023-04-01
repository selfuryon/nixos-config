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
      inputsFrom = [config.mission-control.devShell];
      packages = [ragenix statix colmena];
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
