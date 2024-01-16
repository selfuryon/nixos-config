{
  inputs,
  pkgs,
  ...
}: let
  addons = inputs.firefox-addons.packages.${pkgs.system};
  noToolBar = ''
    #TabsToolbar {
      visibility: collapse !important;
      margin-bottom: 21px !important;
    }

    #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
      visibility: collapse !important;
    }
  '';
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
    package = pkgs.firefox-wayland;
    profiles = {
      personal = {
        id = 0;
        extensions = with addons; [
          ublock-origin
          multi-account-containers
          #grammarly
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
        settings = {"toolkit.legacyUserProfileCustomizations.stylesheets" = true;};
        userChrome = noToolBar;
        isDefault = true;
      };
      work = {
        id = 1;
        extensions = with addons; [
          ublock-origin
          multi-account-containers
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
        settings = {"toolkit.legacyUserProfileCustomizations.stylesheets" = true;};
        userChrome = noToolBar;
      };
      crypto = {
        id = 2;
        extensions = with addons; [
          ublock-origin
          multi-account-containers
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        extraConfig = ''
          ${builtins.readFile ./firefox/arkenfox/user.js}
        '';
        settings = {"toolkit.legacyUserProfileCustomizations.stylesheets" = true;};
        userChrome = noToolBar;
      };
      video = {
        id = 3;
        extensions = with addons; [
          ublock-origin
          multi-account-containers
          keepassxc-browser
          tridactyl
          sidebery
          proton-vpn
          startpage-private-search
        ];
        settings = {"toolkit.legacyUserProfileCustomizations.stylesheets" = true;};
        userChrome = noToolBar;
      };
    };
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
