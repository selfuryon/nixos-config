{pkgs, ...}: {
  networking.firewall.trustedInterfaces = ["podman0" "podman1" "podman2"];
  networking.firewall.allowedUDPPorts = [
    53 # DNS
    5353 # Multicast
  ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = [pkgs.dive pkgs.podman-tui pkgs.podman-compose];
}
