{
  modulesPath,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  # Kernel parameters
  boot = {
    initrd.kernelModules = [];
    initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["kvm-intel"];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    tmp.cleanOnBoot = true;
  };
  zramSwap.enable = false;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/27633110-a62a-4b20-a716-cc8c61358686";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6E24-8770";
    fsType = "vfat";
  };

  swapDevices = [];

  #

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
