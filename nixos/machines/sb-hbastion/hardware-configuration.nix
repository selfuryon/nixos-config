{
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  # Kernel parameters
  boot = {
    initrd.kernelModules = ["nvme"];
    initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "ehci_pci" "virtio_pci" "sr_mod" "virtio_blk"];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };

    extraModulePackages = [];
    tmp.cleanOnBoot = true;
  };
  zramSwap.enable = true;

  fileSystems."/" = {
    device = "/dev/vda3";
    fsType = "ext4";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
