{pkgs, ...}: {
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LANGUAGE = "en_GB.UTF-8";
  #   LC_TIME = "en_GB.UTF-8";
  #   LC_ALL = "en_GB.UTF-8";
  # };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      terminus_font
      monaspace
      inter
      jetbrains-mono
      julia-mono
      noto-fonts
      font-awesome
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Monaspace Argon Var Medium"];
        sansSerif = ["Monaspace Argon Var Medium"];
        monospace = ["Monaspace Neon"];
      };
    };
  };
  console = {
    catppuccin.enable = true;
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
