{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: {
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;
      programs = {
        alejandra.enable = true;
        prettier.enable = true;
      };
    };
    formatter = config.treefmt.build.wrapper;
  };
}
