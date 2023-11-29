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
  i18n.defaultLocale = "en_GB.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LANGUAGE = "en_US.UTF-8";
  #   LC_TIME = "en_GB.UTF-8";
  #   LC_ALL = "en_US.UTF-8";
  # };
  fonts.packages = [pkgs.terminus_font];
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
