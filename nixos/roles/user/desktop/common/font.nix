{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "JetBrainsMono";
      package = pkgs.jetbrains-mono;
    };
    regular = {
      family = "Noto Sans Regular";
      package = pkgs.noto-fonts;
    };
  };
}
