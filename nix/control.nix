{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: {
    mission-control = {
      scripts = {
        fmt = {
          category = "Tools";
          description = "Format the source tree";
          exec = "${lib.getExe config.treefmt.build.wrapper}";
        };
      };
    };
  };
}
