{ config, pkgs, lib, modulesPath, ... }: {

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Boot configuration
  boot = {
    #initrd.systemd.enable = true;
    initrd.kernelModules = [ ];
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_5_19;
    kernelParams = [ "nohibernate" "elevator=none" ];
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    extraModulePackages = [ ];
    cleanTmpDir = true;
  };

  fileSystems = {
    "/" = {
      device = "zroot/system/nixos";
      fsType = "zfs";
    };
    "/nix" = {
      device = "zroot/local/nix";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/data/home";
      fsType = "zfs";
    };
    "/home/syakovlev/data" = {
      device = "zdata/data";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D920-899D";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  # Hardware configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
