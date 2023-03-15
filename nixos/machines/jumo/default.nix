{inputs, ...}: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/pipewire.nix
    ../common/optional/libvirt.nix
    ../common/optional/network-manager.nix
    ../common/optional/printer.nix
    ../common/optional/tailscale.nix
    ../common/optional/netbird.nix
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
