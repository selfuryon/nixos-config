{...}: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/netbird.nix
    # Local role
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "sb-hbastion";
  networking.domain = "ys7.me";
  networking.hostId = "d16f7859";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
