{
  roles,
  users,
  ...
}: {
  imports = [
    # Global configuration
    roles.system.global.default
    # Optional configuration
    roles.system.optional.pipewire
    roles.system.optional.libvirt
    roles.system.optional.network-manager
    roles.system.optional.printer
    roles.system.optional.tailscale
    roles.system.optional.netbird
    roles.system.optional.desktop
    roles.system.optional.impermanence
    # Users
    users.default
    users.syakovlev.desktop
    users.syakovlev.impermanence
    # Local configuration
    ./deploy.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./disko.nix
    ./impermanence.nix
  ];
  networking = {
    hostName = "nemda";
    domain = "ys7.me";
    hostId = "2185078f";
  };

  networking.firewall.trustedInterfaces = ["virbr0"];

  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "24.11";
}
