{ pkgs, inputs, ... }: {
  imports = [
    ./common.nix
    ./suites/wireguard.nix
  ];

}
