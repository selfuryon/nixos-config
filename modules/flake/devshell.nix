{
  perSystem =
    {
      pkgs,
      config,
      ...
    }:
    let
      inherit (pkgs) statix;
    in
    {
      devshells.default = {
        name = "personal";
        packages = [
          statix
        ];
        devshell.startup = {
          pre-commit.text = config.pre-commit.installationScript;
        };
      };
    };
}
