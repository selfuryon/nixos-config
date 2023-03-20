{roles, ...}: {
  imports = [
    # Global configuration
    roles.system.global.default
    # Optional configuration
    roles.system.optional.netbird
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
