{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  themes.fontProfile = {
    enable = true;
    monospace = {
      # family = "JetBrains Mono";
      # package = pkgs.jetbrains-mono;
      family = "Input Mono Narrow";
      package = pkgs.input-fonts;
    };
    regular = {
      family = "Noto Sans";
      package = pkgs.noto-fonts;
    };
  };
}
