{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Local configuration
    ./hardware-configuration.nix
    ./firewall.nix
    ./zfs.nix
  ];

  networking.hostName = "jumo";
  networking.hostId = "ea39aa79";

  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "23.05";
}
