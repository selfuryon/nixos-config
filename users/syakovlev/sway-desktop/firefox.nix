{ config, lib, pkgs, ... }: {
#  programs.firefox = {
#    enable = true;
#    package = pkgs.firefox-wayland;
#    profiles.private = {
#      id = 0;
#      extraConfig = builtins.readFile ./arkenfox/user.js;
#    };
#    profiles.work = {
#      id = 1;
#      extraConfig = builtins.readFile ./arkenfox/user.js;
#    };
#    profiles.crypto = {
#      id = 2;
#      extraConfig = builtins.readFile ./arkenfox/user.js;
#    };
#  };
  home.packages = with pkgs; [ firefox-wayland ];
  xdg.desktopEntries = {
    firefox-work = {
      name = "Firefox (Work)";
      genericName = "Web Browser";
      exec = "firefox -P work %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    }; 
    firefox-crypto = {
      name = "Firefox (Crypto)";
      genericName = "Web Browser";
      exec = "firefox -P crypto %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    }; 
  };
}
