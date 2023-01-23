{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  # Kernel parameters
  boot = {
    initrd.kernelModules = [];
    initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "ehci_pci" "virtio_pci" "sr_mod" "virtio_blk"];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };

    extraModulePackages = [];
    cleanTmpDir = true;
  };
  zramSwap.enable = false;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/73131b3c-e5ca-4b4e-ae9b-3617074e1c22";
    fsType = "ext4";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/b59d11b7-1b39-4d60-b9a5-19c4ea1a7040";}];
}
