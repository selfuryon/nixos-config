{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  fileSystems."/state/system".neededForBoot = true;
  fileSystems."/state/home/syakovlev".neededForBoot = true;

  boot.initrd.systemd.services.rollback = {
    description = "Rollback ZFS datasets to a pristine state";
    wantedBy = [
      "initrd.target"
    ];
    after = [
      "zfs-import-zroot.service"
    ];
    before = [
      "sysroot.mount"
    ];
    path = [pkgs.zfs];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      zfs rollback -r zroot/local/home@blank && echo "rollback complete"
    '';
  };
  environment.persistence."/state/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = {mode = "u=rwx,g=,o=";};
      }
    ];
  };
  environment.persistence."/state/home/syakovlev" = {
    hideMounts = true;
    users.syakovlev = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "src"
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/direnv"
      ];
    };
  };
}
