{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  # Tuxedo InfinityBook Pro 16
  flake.nixosConfigurations.nemda = inputs.nixpkgs.lib.nixosSystem {
    modules = [ nixos.nemda ];
  };

  flake.modules.nixos.nemda =
    { config, ... }:
    {
      imports = with nixos; [
        base
        desktop
        tailscale
        impermanence
        root
        syakovlev
      ];

      home-manager.users.syakovlev.imports = [ homeManager.desktop ];

      networking = {
        hostName = "nemda";
        domain = "ys7.me";
        hostId = "2185078f";
        extraHosts = ''
          127.1.27.1 dirk-01
          127.1.27.2 dirk-02
          127.1.27.3 dirk-03
        '';
      };

      programs.dms-greeter = {
        enable = true;
        compositor.name = "niri";
        # Give the greeter the same DMS look as the desktop. These are the
        # home-manager-generated store paths rather than configHome = $HOME:
        # .config/DankMaterialShell is not persisted and greetd has no ordering
        # against home-manager-syakovlev.service, so $HOME would race an empty dir.
        configFiles =
          let
            hm = config.home-manager.users.syakovlev;
          in
          [
            hm.xdg.configFile."DankMaterialShell/settings.json".source
            hm.xdg.stateFile."DankMaterialShell/session.json".source
          ];
      };

      security.pam.loginLimits = [
        {
          domain = "*";
          type = "-";
          item = "nofile";
          value = "unlimited";
        }
      ];

      time.timeZone = "Asia/Nicosia";
      system.stateVersion = "25.05";
    };
}
