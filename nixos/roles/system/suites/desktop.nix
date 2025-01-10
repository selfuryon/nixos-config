{pkgs, ...}: {
  security.pam.services.hyprlock = {};

  security.polkit.enable = true;
  environment.systemPackages = [pkgs.libsForQt5.polkit-kde-agent];

  services = {
    dbus.packages = [pkgs.gcr];
  };

  programs = {
    ssh.startAgent = true;
    light.enable = true;
  };

  hardware.graphics.enable = true;
}
