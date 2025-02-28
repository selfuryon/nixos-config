{
  inputs,
  pkgs,
  ...
}: let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  home.persistence."/state/home/syakovlev".directories = [
    ".mozilla/firefox/personal"
    ".mozilla/firefox/work"
    ".mozilla/firefox/video"
    ".mozilla/firefox/crypto"
  ];
  home.packages = with pkgs; [tridactyl-native];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    profiles = {
      personal = {
        id = 0;
        extensions.packages = with addons; [
          ublock-origin
          keepassxc-browser
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        extraConfig = ''
          ${builtins.readFile ./firefox/arkenfox/user.js}
          ${builtins.readFile ./firefox/private.js}
        '';
        settings = {
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.revamp.round-content-area" = true;
          "browser.tabs.groups.enabled" = true;
        };
        isDefault = true;
      };
      work = {
        id = 1;
        extensions.packages = with addons; [
          ublock-origin
          keepassxc-browser
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        extraConfig = ''
          ${builtins.readFile ./firefox/arkenfox/user.js}
          ${builtins.readFile ./firefox/work.js}
        '';
        settings = {
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.revamp.round-content-area" = true;
          "browser.tabs.groups.enabled" = true;
        };
      };
      crypto = {
        id = 2;
        extensions.packages = with addons; [
          ublock-origin
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        extraConfig = ''
          ${builtins.readFile ./firefox/arkenfox/user.js}
        '';
        settings = {
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.revamp.round-content-area" = true;
          "browser.tabs.groups.enabled" = true;
        };
      };
      video = {
        id = 3;
        extensions.packages = with addons; [
          ublock-origin
          keepassxc-browser
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        settings = {
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.revamp.round-content-area" = true;
          "browser.tabs.groups.enabled" = true;
        };
      };
    };
  };
  xdg = {
    desktopEntries = {
      firefox-work = {
        name = "Firefox (Work)";
        genericName = "Web Browser";
        exec = "firefox-beta -P work %U";
        icon = "firefox";
        terminal = false;
      };
      firefox-crypto = {
        name = "Firefox (Crypto)";
        genericName = "Web Browser";
        exec = "firefox-beta -P crypto %U";
        icon = "firefox";
        terminal = false;
      };
      firefox-video = {
        name = "Firefox (Video)";
        genericName = "Web Browser";
        exec = "firefox-beta -P video %U";
        icon = "firefox";
        terminal = false;
      };
    };
  };
}
