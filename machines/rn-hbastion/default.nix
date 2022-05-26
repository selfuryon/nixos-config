{ inputs, pkgs, ... }: {
  imports = with inputs.self.roles; [
    # Global role
    server
    # Local role
    ./firewall.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./wireguard.nix
  ];

  networking.hostName = "rn-hbastion";
  networking.hostId = "0c61dae4";

  time.timeZone = "Etc/UTC";
  system.stateVersion = "unstable";

  # Kernel parameters
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };
  };
  boot.cleanTmpDir = true;
  zramSwap.enable = true;
}
