{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Global role
    server
    # Local role
    ./agenix.nix
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./wireguard.nix
  ];

  networking.hostName = "v2d-hbastion";
  networking.hostId = "0c61dae4";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "unstable";
}
