{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      ui.pane_frames.rounded_corners = true;
      theme = "github-theme";
      themes.github-theme = {
        # Bright
        bg = "#ffffff";
        fg = "#24292f";
        black = "#959da5";
        red = "#cb2431";
        green = "#22863a";
        yellow = "#b08800";
        blue = "#005cc5";
        magenta = "#5a32a3";
        cyan = "#3192aa";
        white = "#d1d5da";
        orange = "#d18616";
      };
    };
  };
}
