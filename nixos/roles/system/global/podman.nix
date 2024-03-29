{pkgs, ...}: {
  environment.systemPackages = with pkgs; [podman-compose];
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
