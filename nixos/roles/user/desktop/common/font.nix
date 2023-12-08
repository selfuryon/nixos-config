{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "Monaspace Neon";
      package = pkgs.monaspace;
      #family = "JetBrainsMono Nerd Font";
      #package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    };
    regular = {
      #family = "Inter";
      #package = pkgs.inter;
      family = "Monaspace Argon Var Medium";
      package = pkgs.monaspace;
    };
  };
}
