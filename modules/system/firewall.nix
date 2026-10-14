{
  flake.modules.nixos.base = {
    # Firewall
    networking = {
      firewall.enable = true;
      nftables.enable = true;
    };
  };
}
