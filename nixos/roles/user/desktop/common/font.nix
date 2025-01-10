{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  themes.fontProfile = {
    enable = true;
    monospace = {
      family = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
    };
    regular = {
      family = "Noto Sans";
      package = pkgs.noto-fonts;
    };
  };
}
