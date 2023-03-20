{roles, ...}: {
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
    # Local configuration
    ./hardware-configuration.nix
    ./zfs.nix
  ];

  networking.hostName = "jumo";
  networking.domain = "ys7.me";
  networking.hostId = "ea39aa79";

  networking.firewall.trustedInterfaces = ["virbr0"];

  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "23.05";
}
