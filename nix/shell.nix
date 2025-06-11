{
  perSystem = {
    pkgs,
    # inputs',
    config,
    ...
  }: let
    inherit (pkgs) statix;
    # inherit (inputs'.ragenix.packages) ragenix;
    # inherit (inputs'.colmena.packages) colmena;
  in {
    devshells.default = {
      name = "personal";
      packages = [
        statix
        # ragenix
        # colmena
      ];
      devshell.startup = {
        pre-commit.text = config.pre-commit.installationScript;
      };
    };
  };
}
