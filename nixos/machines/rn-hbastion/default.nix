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

  networking = {
    hostName = "rn-hbastion";
    domain = "ys7.me";
    hostId = "0c61dae4";
  };

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.11";

  services.netbird.enable = true;
}
