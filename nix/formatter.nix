{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    treefmt.config = {
      projectRootFile = ".git/config";
      settings.global.excludes = ["flake.lock"];
      package = pkgs.treefmt;
      programs = {
        alejandra.enable = true;
        prettier.enable = true;
      };
    };
    formatter = config.treefmt.build.wrapper;
  };
}
