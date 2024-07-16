{pkgs, ...}: {
  security.pam.services.hyprlock = {};

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [polkit_gnome];

  services = {
    dbus.packages = [pkgs.gcr];
  };

  programs = {
    ssh.startAgent = true;
    light.enable = true;
  };

  hardware.graphics.enable = true;
}
