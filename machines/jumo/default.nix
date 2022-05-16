{ inputs, config, pkgs, ... }: {

  imports = with inputs.self.roles; [
    # Global role
    desktop
    # Local configuration
    ./hardware-configuration.nix
    ./firewall.nix
    ./groups.nix
    ./zfs.nix
  ];

  networking.hostName = "jumo";
  networking.hostId = "ea39aa79";

  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "unstable";

  # Hardware configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };

  # Kernel parameters
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_5_16;
    kernelParams = [ "nohibernate" "elevator=none" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
