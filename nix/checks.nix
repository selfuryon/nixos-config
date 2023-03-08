{inputs, ...}: {
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
        #statix.enable = true;
      };
    };
    # checks =
    #   builtins.mapAttrs
    #   (system: deployLib: deployLib.deployChecks self'.deploy)
    #   inputs.deploy-rs.lib;
  };
}
