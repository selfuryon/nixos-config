{ pkgs, ... }:
{
  security.pam.services.hyprlock = { };

  security.polkit.enable = true;
  environment.systemPackages = [ pkgs.kdePackages.polkit-kde-agent-1 ];

  services = {
    dbus.packages = [ pkgs.gcr ];
  };

  services.gnome.gcr-ssh-agent.enable = false;
  programs = {
    ssh.startAgent = true;
    light.enable = true;
  };

  hardware.graphics.enable = true;
}
