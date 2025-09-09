{
  services.tailscale.enable = true;
  networking.firewall = {
    checkReversePath = "loose";
    allowedUDPPorts = [ 41641 ]; # Facilitate firewall punching
  };
  boot.kernel.sysctl = {
    "net.ipv4.conf.tailscale0.rp_filter" = 2;
  };
}
