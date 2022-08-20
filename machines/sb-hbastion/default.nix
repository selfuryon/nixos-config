{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Local role
    ./agenix.nix
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./wireguard.nix
  ];

  networking.hostName = "sb-hbastion";
  networking.hostId = "d16f7859";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "22.11";
}
