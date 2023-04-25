{
  perSystem = {
    pkgs,
    config,
    inputs',
    ...
  }: let
    inherit (pkgs) mkShellNoCC;
  in {
    devShells.default = mkShellNoCC {
      name = "etherno-iac";
      inputsFrom = [
        config.flake-root.devShell
        config.mission-control.devShell
        #config.pre-commit.devShell
      ];
      packages = builtins.attrValues {
        inherit (pkgs) statix;
        inherit (inputs'.ragenix.packages) ragenix;
        inherit (inputs'.colmena.packages) colmena;
      };
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
