{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  fileSystems."/state/system".neededForBoot = true;
  fileSystems."/state/home".neededForBoot = true;

  # https://discourse.nixos.org/t/impermanence-vs-systemd-initrd-w-tpm-unlocking/25167/2
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
      zfs rollback -r zroot/system/root@blank && echo "system/root: rollback complete"
      zfs rollback -r zroot/system/home@blank && echo "system/home: rollback complete"
    '';
  };
  programs.fuse.userAllowOther = true;
  environment.persistence."/state/system" = {
    hideMounts = true;
    directories = [
      {
        directory = "/etc/secureboot";
        mode = "u=rwx,g=rx,o=";
      }
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
  system.activationScripts."10-persistent-dirs".text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /state/home/${user.home}
        chown ${user.name}:${user.group} /state/home/${user.home}
        chmod ${user.homeMode} /state/home/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);
}
