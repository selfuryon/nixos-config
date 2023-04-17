{
  modulesPath,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  # Kernel parameters
  boot = {
    initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
    initrd.kernelModules = [];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];
    extraModulePackages = [];
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };

    tmp.cleanOnBoot = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c032a44c-76a1-4e03-ab13-6d6935377bdc";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/swapfile";
      priority = 0;
      size = 4096;
    }
  ];

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
