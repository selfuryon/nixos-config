{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Global role
    server
    # Local role
    #./agenix.nix
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    #./wireguard.nix
  ];

  networking.hostName = "tylze";
  networking.hostId = "ceb59ca1";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "22.11";
}
