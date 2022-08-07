{ pkgs, inputs, ... }: {
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

  users.mutableUsers = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [ vim ];

  # services.greetd = {
  # enable = true;
  # settings = {
  # terminal.vt=2;
  # default_session = {
  # command =
  # "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'systemd-cat -t sway sway'";
  # };
  # };
  # };

}
