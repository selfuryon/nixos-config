{inputs, ...}: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/netbird.nix
    # Local role
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "tylze";
  networking.domain = "ys7.me";
  networking.hostId = "ceb59ca1";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
