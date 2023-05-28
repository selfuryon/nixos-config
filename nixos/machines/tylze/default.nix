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
    ./deploy.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "tylze";
  networking.domain = "ys7.me";
  networking.hostId = "ceb59ca1";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
