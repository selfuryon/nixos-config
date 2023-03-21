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

  networking.hostName = "vlr-wbastion";
  networking.domain = "ys7.me";
  networking.hostId = "59cb960f";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
