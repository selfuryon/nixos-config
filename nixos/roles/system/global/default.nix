{
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./dns.nix
    ./firewall.nix
    ./net-sysctl.nix
    ./nix.nix
    ./podman.nix
    ./sshd.nix
    ./sudo.nix
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [vim sbctl];

  security.doas.enable = true;
  #security.sudo.enable = false;

  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    config = {allowUnfree = true;};
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
}
