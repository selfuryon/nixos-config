{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Global configuration
    ../common/global
    # Local role
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "rn-hbastion";
  networking.domain = "ys7.me";
  networking.hostId = "0c61dae4";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";

  services.netbird.enable = true;
}
