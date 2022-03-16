{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./dns.nix
    ./firewall.nix
    ./groups.nix
    ./networking.nix
    ./ssh.nix
    ./wireguard.nix
  ];

  networking.hostName = "sb-hbastion";
  networking.hostId = "d16f7859";

  time.timeZone = "Europe/Moscow";
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
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      dates = "03:15";
    };
  };
}
