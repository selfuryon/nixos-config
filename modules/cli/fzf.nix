{
  flake.modules.homeManager.cli = {
    programs.fzf = {
      enable = true;
      enableNushellIntegration = false;
      # Atuin owns Ctrl-R for history search
      historyWidget.command = "";
    };
  };
}
