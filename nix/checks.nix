{
  perSystem = _: {
    pre-commit.settings = {
      hooks = {
        alejandra.enable = true;
        prettier.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };
  };
}
