{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif
    font-awesome
    dejavu_fonts
  ];

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      #family = "FantasqueSansM Nerd Font Mono";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FantasqueSansMono"];};
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
