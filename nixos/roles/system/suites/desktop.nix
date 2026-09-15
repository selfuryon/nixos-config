{ pkgs, ... }:
{
  security.pam.services.hyprlock = { };

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.polkit-kde-agent-1
    brightnessctl
  ];

  services = {
    # gcr_3, not gcr_4: only the 3.x output ships the org.gnome.keyring.*Prompter
    # dbus services (upstream gnome-keyring.nix does the same).
    dbus.packages = [ pkgs.gcr_3 ];
  };

  services.gnome.gcr-ssh-agent.enable = false;
  programs.ssh.startAgent = true;

  hardware.graphics.enable = true;
}
