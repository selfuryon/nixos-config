{
  config,
  pkgs,
  inputs,
  roles,
  users,
  ...
}:
let
  override.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
in
{
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
    extraHosts = ''
      127.1.27.1 dirk-01
      127.1.27.2 dirk-02
      127.1.27.3 dirk-03
    '';
  };
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --time --theme border=blue;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
  #       user = "greeter";
  #     };
  #   };
  # };
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

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services = {
    # intel_pstate is already on the "powersave" governor; bias the hardware
    # (HWP) towards efficiency instead of the default balance_performance.
    cpu-epp = {
      description = "Set CPU energy performance preference";
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-modules-load.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
          echo balance_power > "$f"
        done
      '';
    };
    # Unexplained hard power-offs leave nothing in the journal; cap package
    # power (i7-13700H defaults to PL1=PL2=45W) to keep it out of thermal
    # trouble.
    cpu-power-limits = {
      description = "Set Intel RAPL package power limits";
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-modules-load.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        rapl=/sys/class/powercap/intel-rapl:0
        echo 30000000 > $rapl/constraint_0_power_limit_uw # long_term
        echo 40000000 > $rapl/constraint_1_power_limit_uw # short_term
      '';
    };
    # Log temperatures/power every 5s so the last lines before a power-off
    # show what the hardware was doing. `journalctl -b -1 -t thermal-log`.
    thermal-log = {
      description = "Periodic thermal and power logging";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        SyslogIdentifier = "thermal-log";
        Restart = "always";
      };
      path = [ pkgs.coreutils ];
      script = ''
        rapl=/sys/class/powercap/intel-rapl:0/energy_uj
        max=$(cat /sys/class/powercap/intel-rapl:0/max_energy_range_uj)
        prev=$(cat $rapl)
        for z in /sys/class/thermal/thermal_zone*; do
          case $(cat $z/type) in
            x86_pkg_temp) pkgz=$z/temp ;;
            acpitz) acpiz=''${acpiz:-$z/temp} ;;
          esac
        done
        for h in /sys/class/hwmon/hwmon*; do
          [ "$(cat $h/name)" = nvme ] && nvmez=''${nvmez:-$h/temp1_input}
        done
        while sleep 5; do
          now=$(cat $rapl)
          watts=$(( ((now - prev + max) % max) / 5000000 ))
          prev=$now
          pkg=$(( $(cat $pkgz) / 1000 ))
          acpi=$(( $(cat $acpiz) / 1000 ))
          nvme=$(( $(cat $nvmez) / 1000 ))
          mhz=$(( $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | sort -n | tail -1) / 1000 ))
          ac=$(cat /sys/class/power_supply/AC0/online)
          bat=$(cat /sys/class/power_supply/BAT0/capacity)
          echo "pkg=''${pkg}C acpi=''${acpi}C nvme=''${nvme}C pwr=''${watts}W maxfreq=''${mhz}MHz ac=$ac bat=$bat%"
        done
      '';
    };
    # Temprorary for freeze after sleep mode
    systemd-suspend = override;
    systemd-hibernate = override;
    systemd-hybrid-sleep = override;
    systemd-suspend-then-hibernate = override;
    # greetd.serviceConfig = {
    #   Type = "idle";
    #   StandardInput = "tty";
    #   StandardOutput = "tty";
    #   StandardError = "journal"; # Without this errors will spam on screen
    #   # Without these bootlogs will spam on screen
    #   TTYReset = true;
    #   TTYVHangup = true;
    #   TTYVTDisallocate = true;
    # };
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "unlimited";
    }
  ];

  programs = {
    niri.enable = true;
    niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;
    # uwsm.enable = false;
    # hyprland = {
    #   enable = false;
    #   withUWSM = true;
    #   xwayland.enable = true;
    # };
  };
  time.timeZone = "Asia/Nicosia";
  system.stateVersion = "25.05";
}
