{
  programs.zellij = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      ui.pane_frames.rounded_corners = true;
      # theme = "catppuccin-latte";
    };
  };
  xdg.configFile."zellij/layouts" = {
    source = ./zellij/layouts;
    recursive = true;
  };
}
