{...}: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/netbird.nix
    # Local role
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