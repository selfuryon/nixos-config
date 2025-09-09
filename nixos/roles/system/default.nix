{
  pkgs,
  inputs,
  self,
  ...
}:
{
  imports = [
    ./suites/dns.nix
    ./suites/firewall.nix
    ./suites/fonts.nix
    ./suites/net-sysctl.nix
    ./suites/nix.nix
    ./suites/podman.nix
    ./suites/sshd.nix
    ./suites/sudo.nix
  ];

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [
    vim
    sbctl
  ];

  security.doas.enable = true;
  #security.sudo.enable = false;

  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=infinity
  '';

  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
      permittedInsecurePackages = [
        "freeimage-unstable-2021-11-01"
        "electron-28.3.3"
        "electron-27.3.11"
      ];
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
