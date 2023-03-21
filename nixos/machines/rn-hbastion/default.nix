{
  roles,
  users,
  ...
}: {
  imports = [
    # Global configuration
    roles.system.global.default
    # Optional configuration
    roles.system.optional.netbird
    # Users
    users.default
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
