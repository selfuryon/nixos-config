{ inputs, hostname, pkgs, lib, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    imports = [ ./features/desktop/hyprland ];
  };

  security.pam.services.swaylock = { text = "auth include login"; };
  #security.pam.services.swaylock = {};

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  services = { dbus.packages = [ pkgs.gcr ]; };

  programs = {
    ssh.startAgent = true;
    light.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  qt5.platformTheme = "qt5ct";
}
