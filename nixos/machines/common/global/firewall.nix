{pkgs, ...}: {
  # Firewall
  networking = {
    firewall.enable = true;
    nftables.enable = true;
  };
}
