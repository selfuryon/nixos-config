{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    #hermit
    #b612
    victor-mono
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif
    font-awesome
  ];

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
