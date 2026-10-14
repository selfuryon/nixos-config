{
  flake.modules.homeManager.cli = {
    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          lightTheme = true;
        };
      };
    };
  };
}
