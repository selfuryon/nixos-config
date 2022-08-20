{ pkgs, inputs, ... }: {
  imports = [
    ./suites/dns.nix
    ./suites/net-sysctl.nix
    ./suites/sshd.nix
    ./suites/nix.nix
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [ vim ];

  security.doas.enable = true;
  #security.sudo.enable = false;
}
