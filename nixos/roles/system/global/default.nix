{
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./dns.nix
    ./firewall.nix
    ./fonts.nix
    ./net-sysctl.nix
    ./nix.nix
    ./podman.nix
    ./sshd.nix
    ./sudo.nix
  ];

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [vim sbctl];

  security.doas.enable = true;
  #security.sudo.enable = false;

  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = ["electron-24.8.6"];
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
}
