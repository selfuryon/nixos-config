{
  perSystem = {
    pkgs,
    config,
    self',
    inputs',
    ...
  }: let
    inherit (pkgs) mkShellNoCC;
    inherit (inputs'.deploy-rs.packages) deploy-rs;
    inherit (inputs'.ragenix.packages) ragenix;
    inherit (pkgs) statix;
  in {
    devShells.default = mkShellNoCC {
      name = "etherno-iac";
      inputsFrom = [config.mission-control.devShell];
      packages = [deploy-rs ragenix statix];
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
