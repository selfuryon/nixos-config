{ config, pkgs, inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./hardware-configuration.nix
    dns
    ssh
    virtualization
    pipewire
    net-sysctl
    ./firewall.nix
    ./fonts.nix
    ./groups.nix
    ./networking.nix
    ./wireguard.nix
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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [ polkit_gnome vim ];

  services = {
    dbus.packages = [ pkgs.gcr ];
    #openssh.enable = true;
    #printing.enable = true;
  };

  programs = {
    ssh.startAgent = true;
    firejail.enable = true;
    light.enable = true;
    qt5ct.enable = true;

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [ ];
    };
  };

  security.pam.services.swaylock = { };

  # Nix 
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "03:15";
    };
  };
}
