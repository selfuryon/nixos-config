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
          zfs set keylocation="prompt" "zroot";
        '';
        datasets = {
          local.type = "zfs_fs";
          "local/reserved" = {
            type = "zfs_fs";
            options.reservation = "30G";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
            options.relatime = "off";
          };
          system.type = "zfs_fs";
          "system/root" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            postCreateHook = "zfs snapshot zroot/system/root@blank";
          };
          "system/home" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            postCreateHook = "zfs snapshot zroot/system/home@blank";
          };
          "system/tmp" = {
            type = "zfs_fs";
            mountpoint = "/tmp";
            options.mountpoint = "legacy";
            postCreateHook = "zfs snapshot zroot/system/tmp@blank";
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
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=10G"
          "defaults"
          "mode=755"
        ];
      };
    };
  };
}
