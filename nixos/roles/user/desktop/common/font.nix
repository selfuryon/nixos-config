{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif
    font-awesome
    dejavu_fonts
    monaspace
  ];

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "Monaspace Neon";
      package = pkgs.monaspace;
      #family = "JetBrainsMono Nerd Font";
      #package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
