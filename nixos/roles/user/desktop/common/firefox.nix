{
  inputs,
  pkgs,
  ...
}:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  home.persistence."/state/home/syakovlev".directories = [
    ".mozilla/firefox"
  ];
  home.packages = with pkgs; [ tridactyl-native ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    profiles = {
      default = {
        id = 0;
        extensions.force = true;
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
    };
  };
  # xdg = {
  #   desktopEntries = {
  #     firefox-work = {
  #       name = "Firefox (Work)";
  #       genericName = "Web Browser";
  #       exec = "firefox-beta -P work %U";
  #       icon = "firefox";
  #       terminal = false;
  #     };
  #   };
  # };
}
