{
  programs.zellij = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      ui.pane_frames.rounded_corners = true;
      # theme = "catppuccin-latte";
      keybinds = {
        "shared_except \"locked\"" = {
          "bind \"Alt f\"" = {
            "LaunchPlugin \"filepicker\"" = {
              #floating=true;
              close_on_selection = true;
            };
          };
        };
      };
    };
  };
  xdg.configFile."zellij/layouts" = {
    source = ./zellij/layouts;
    recursive = true;
  };
}
