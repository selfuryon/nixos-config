{pkgs, ...}: {
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
}
