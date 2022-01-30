{ pkgs, ... }: {
  xdg.mimeApps.defaultApplications = {};
  xdg.configFile = let dPath = ./dotfiles; in
  {
    nvim = {
      source = "${dPath}/nvim";
      recursive = true;
    };
    swaylock = {
      source = "${dPath}/swaylock";
      recursive = true;
    };
    waybar = {
      source = "${dPath}/waybar";
      recursive = true;
    };
    wofi = {
      source = "${dPath}/wofi";
      recursive = true;
    };
    alacritty = {
      source = "${dPath}/alacritty";
      recursive = true;
    };
    bat = {
      source = "${dPath}/bat";
      recursive = true;
    };
  };
}
