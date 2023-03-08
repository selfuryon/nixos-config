{...}: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/netbird.nix
    # Local role
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "vlr-wbastion";
  networking.domain = "ys7.me";
  networking.hostId = "59cb960f";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
