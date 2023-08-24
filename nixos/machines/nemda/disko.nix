{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      nvme1n1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        options = {
          ashift = "13";
          autotrim = "on";
        };
        rootFsOptions = {
          atime = "off";
          relatime = "on";
          compression = "zstd";
          mountpoint = "none";
          dnodesize = "auto";
          acltype = "posix";
          xattr = "sa";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "file:///tmp/secret.key";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = ''
          zfs snapshot zroot/local/home@blank
        '';

        datasets = {
          local.type = "zfs_fs";
          "local/reserved" = {
            type = "zfs_fs";
            options.reservation = "15G";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
            options.relatime = "off";
          };
          "local/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "legacy";
            postCreateHook = "zfs snapshot zroot/local/home@blank";
          };
          state = {
            type = "zfs_fs";
            options."com.sun:auto-snapshot" = "true";
          };
          "state/system" = {
            type = "zfs_fs";
            mountpoint = "/state/system";
            options.mountpoint = "legacy";
          };
          "state/home" = {
            type = "zfs_fs";
            mountpoint = "/state/home";
            options.mountpoint = "legacy";
            options.recordsize = "1M";
          };
          "state/home/syakovlev" = {
            type = "zfs_fs";
            mountpoint = "/state/home/syakovlev";
            options.mountpoint = "legacy";
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
          "defaults"
          "mode=755"
        ];
      };
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=500M"
        ];
      };
    };
  };
}
