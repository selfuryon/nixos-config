{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./dns.nix
    ./firewall.nix
    ./groups.nix
    ./networking.nix
    ./ssh.nix
  ];

  networking.hostName = "v2d-hbastion";
  networking.hostId = "0c61dae4";

  time.timeZone = "Europe/Moscow";
  system.stateVersion = "21.11";

  # Kernel parameters
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [ vim ];

  # Nix 
  nixpkgs.config.allowUnfree = true;
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      dates = "03:15";
    };
  };
}
