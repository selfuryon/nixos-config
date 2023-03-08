{
  perSystem = {
    pkgs,
    config,
    self',
    inputs',
    ...
  }: let
    inherit (config.mission-control) installToDevShell;
    inherit (pkgs) mkShellNoCC;
    inherit (inputs'.deploy-rs.packages) deploy-rs;
    inherit (inputs'.ragenix.packages) ragenix;
    inherit (pkgs) statix;
  in {
    devShells.default = let
      shell = mkShellNoCC {
        name = "etherno-iac";
        packages = [deploy-rs ragenix statix];
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    in
      installToDevShell shell;
  };
}
