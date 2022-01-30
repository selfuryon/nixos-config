{ config, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix 
    ./dns.nix 
    ./fonts.nix 
    ./networking.nix 
    ./pipewire.nix 
    ./sound.nix 
    ./virtualization.nix 
    ./zfs.nix 
  ];

  networking.hostName = "jumo";
  networking.hostId = "ea39aa79";

  time.timeZone = "Europe/Moscow";
  system.stateVersion = "unstable"; 

  # Hardware configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };

  # Kernel parameters
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_5_15;
    kernelParams = [ "nohibernate" "elevator=none" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  services = {
    dbus.packages = [ pkgs.gcr ];
    #openssh.enable = true;
    #printing.enable = true;
  };

  programs = {
    ssh.startAgent = true;
  };

  # Nix 
  nixpkgs.config.allowUnfree = true;
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "03:15";
    };
  };
}
