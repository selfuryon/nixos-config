{ config, pkgs, inputs, ... }: {
  imports = [
    ./suites/dns.nix
    ./suites/fonts.nix
    ./suites/net-sysctl.nix
    ./suites/network-manager.nix
    ./suites/pipewire.nix
    ./suites/sshd.nix
    ./suites/virtualization.nix
    ./suites/wireguard.nix
    ./suites/nix.nix
  ];

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
}