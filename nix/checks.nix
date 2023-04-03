{
  perSystem = {
    config,
    pkgs,
    lib,
    self',
    inputs',
    ...
  }: {
    pre-commit.settings = {
      hooks = {
        alejandra.enable = true;
        prettier.enable = true;
        statix.enable = true;
      };
    };
  };
}
