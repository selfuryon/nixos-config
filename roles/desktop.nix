{ pkgs, inputs, ... }: {
  imports = [
    ./common.nix
    ./suites/fonts.nix
    ./suites/pipewire.nix
    ./suites/virtualization.nix
    ./suites/network-manager.nix
    ./suites/wireguard.nix
  ];

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
