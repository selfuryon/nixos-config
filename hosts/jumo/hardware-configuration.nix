{ config, lib, pkgs, modulesPath, ... }: {

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "zroot/system/nixos";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zroot/local/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/data/home";
      fsType = "zfs";
    };

  fileSystems."/home/syakovlev/data" =
    { device = "zdata/data";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D920-899D";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
