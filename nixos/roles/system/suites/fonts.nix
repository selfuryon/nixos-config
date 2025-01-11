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
      noto-fonts
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrains Mono"];
      };
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
