{ inputs, config, pkgs, ... }: {
  imports = with inputs.self.roles; [
    # Global role
    server
    # Local role
    ./firewall.nix
    ./groups.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./wireguard.nix
  ];

  networking.hostName = "sb-hbastion";
  networking.hostId = "d16f7859";

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
