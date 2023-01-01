{ inputs, ... }: {
  imports = [
    # Global configuration
    ../common/global
    ../common/optional/fonts.nix
    ../common/optional/pipewire.nix
    ../common/optional/libvirt.nix
    ../common/optional/network-manager.nix
    # Local configuration
    ./hardware-configuration.nix
    ./firewall.nix
    ./zfs.nix
  ];

  networking.hostName = "jumo";
  networking.domain = "ys7.me";
  networking.hostId = "ea39aa79";

  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "23.05";
}
