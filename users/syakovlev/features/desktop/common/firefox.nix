{
  inputs,
  pkgs,
  lib,
  ...
}: let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  home.packages = with pkgs; [tridactyl-native];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    extensions = with addons; [
      ublock-origin
      auto-tab-discard
      multi-account-containers
      #languagetool
      history-cleaner
      keepassxc-browser
      smart-referer
      startpage-private-search
      tridactyl
    ];
    profiles.private = {
      id = 0;
      extraConfig = ''
        ${builtins.readFile ./firefox/arkenfox/user.js}
        ${builtins.readFile ./firefox/work.js}
      '';
      isDefault = true;
    };
    profiles.work = {
      id = 1;
      extraConfig = ''
        ${builtins.readFile ./firefox/arkenfox/user.js}
        ${builtins.readFile ./firefox/work.js}
      '';
    };
    profiles.crypto = {
      id = 2;
      extraConfig = ''
        ${builtins.readFile ./firefox/arkenfox/user.js}
      '';
    };
    profiles.video = {id = 3;};
  };
  xdg = {
    desktopEntries = {
      firefox-work = {
        name = "Firefox (Work)";
        genericName = "Web Browser";
        exec = "firefox -P work %U";
        terminal = false;
        categories = ["Application" "Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };
      firefox-crypto = {
        name = "Firefox (Crypto)";
        genericName = "Web Browser";
        exec = "firefox -P crypto %U";
        terminal = false;
      };
      firefox-video = {
        name = "Firefox (Video)";
        genericName = "Web Browser";
        exec = "firefox -P video %U";
        terminal = false;
      };
    };
  };
}
