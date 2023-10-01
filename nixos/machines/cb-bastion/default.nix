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
    ./disks.nix
    ./networking.nix
  ];
  networking = {
    hostName = "cb-bastion";
    domain = "ys7.me";
    hostId = "c52e26ca";
  };

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.11";

  services.netbird.enable = true;
}
