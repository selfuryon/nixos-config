{
  inputs,
  pkgs,
  ...
}:
let
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.persistence."/state".directories = [
    ".mozilla/firefox"
    ".config/mozilla/firefox"
  ];
  home.packages = with pkgs; [ tridactyl-native ];
  programs.firefox = {
    enable = true;
    # The firefox package hardcodes MOZ_LEGACY_PROFILES=1, so the browser reads
    # ~/.mozilla/firefox. Pin configPath to match — otherwise (with
    # stateVersion >= 25.05) home-manager writes the profile to the XDG path
    # ~/.config/mozilla/firefox, which firefox never reads. This legacy path is
    # also the one persisted in impermanence.nix.
    configPath = ".mozilla/firefox";
    package = pkgs.firefox; # TODO: switch back to firefox-beta when hydra builds 148.0b15
    profiles = {
      default = {
        id = 0;
        extensions.force = true;
        extensions.packages = with addons; [
          ublock-origin
          keepassxc-browser
          tridactyl
          sidebery
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
