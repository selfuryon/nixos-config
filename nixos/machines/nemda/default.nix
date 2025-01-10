{
  roles,
  users,
  ...
}: {
  imports = [
    # Global configuration
    roles.system.notebook
    # Optional configuration
    roles.system.suites.tailscale
    roles.system.suites.impermanence
    # Users
    users.default
    users.syakovlev.desktop
    users.syakovlev.impermanence
    # Local configuration
    ./deploy.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./disko.nix
    ./impermanence.nix
  ];
  networking = {
    hostName = "nemda";
    domain = "ys7.me";
    hostId = "2185078f";
  };

  networking.firewall.trustedInterfaces = ["virbr0"];
  programs = {
    # uwsm.enable = false;
    # hyprland = {
    #   enable = false;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };
    # xwayland.enable = lib.mkForce false;
    niri.enable = true;
    regreet = {
      enable = true;
      settings.background = {
        fit = "Contain";
        path = "/home/syakovlev/Pictures/login_screen.jpg";
      };
    };
  };
  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "25.05";
}
