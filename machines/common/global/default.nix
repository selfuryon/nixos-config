{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.age
    ./dns.nix
    ./net-sysctl.nix
    ./netbird.nix
    ./nix.nix
    ./podman.nix
    ./sshd.nix
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [vim];

  security.doas.enable = true;
  #security.sudo.enable = false;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
}
