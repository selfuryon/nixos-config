{
  pkgs,
  config,
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
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --time --theme border=blue;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
        user = "greeter";
      };
    };
  };

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  programs = {
    # uwsm.enable = false;
    # hyprland = {
    #   enable = false;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };
    # xwayland.enable = lib.mkForce false;
    niri.enable = true;
    # regreet = {
    #   enable = true;
    #   settings.background = {
    #     fit = "Contain";
    #     path = "/home/syakovlev/Pictures/login_screen.jpg";
    #   };
    # };
  };
  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "25.05";
}
