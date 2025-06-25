{pkgs, ...}: {
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = [pkgs.dive pkgs.podman-tui pkgs.podman-compose];
}
