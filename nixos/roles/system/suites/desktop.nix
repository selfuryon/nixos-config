{ pkgs, ... }:
{
  security.pam.services.hyprlock = { };

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.polkit-kde-agent-1
    brightnessctl
  ];

  services = {
    dbus.packages = [ pkgs.gcr ];
  };

  services.gnome.gcr-ssh-agent.enable = false;
  programs.ssh.startAgent = true;

  hardware.graphics.enable = true;
}
