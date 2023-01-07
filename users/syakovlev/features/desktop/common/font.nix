{ pkgs, ... }: {
  home.packages = with pkgs; [
    noto-fonts
    hermit
    b612
    fira-code
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif
    font-awesome
    inter
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
