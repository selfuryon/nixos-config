{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Local role
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    #./wireguard.nix
  ];

  networking.hostName = "tylze";
  networking.hostId = "ceb59ca1";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
