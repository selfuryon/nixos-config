{ pkgs, inputs, ... }: {
  imports = [
    ./suites/dns.nix
    ./suites/net-sysctl.nix
    ./suites/sshd.nix
    ./suites/wireguard.nix
    ./suites/nix.nix
  ];

  users.mutableUsers = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [ vim ];
}
