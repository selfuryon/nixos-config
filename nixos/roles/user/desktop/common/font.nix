{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  themes.fontProfile = {
    enable = true;
    monospace = {
      #family = "Monaspace Neon";
      #package = pkgs.monaspace;
      family = "JetBrainsMono";
      package = pkgs.jetbrains-mono;
    };
    regular = {
      family = "Monaspace Argon Var Medium";
      package = pkgs.monaspace;
    };
  };
}
