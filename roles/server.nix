{ config, pkgs, inputs, ... }: {
  imports = [
    ./suites/dns.nix
    ./suites/net-sysctl.nix
    ./suites/networking.nix
    ./suites/sshd.nix
    ./suites/wireguard.nix
  ];

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
