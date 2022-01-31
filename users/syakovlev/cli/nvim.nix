{ pkgs, ... }: {
  xdg.configFile = {
    nvim = {
      source = ./nvim;
      recursive = true;
    };
  };
}
