{ inputs, ... }: {
  imports = with inputs.self.roles; [
    # Global configuration
    ../common/global
    # Local role
    #./agenix.nix
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    #./wireguard.nix
  ];

  networking.hostName = "vlr-wbastion";
  networking.domain = "ys7.me";
  networking.hostId = "59cb960f";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "23.05";
}
