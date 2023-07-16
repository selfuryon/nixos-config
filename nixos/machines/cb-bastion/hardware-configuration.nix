{
  inputs,
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
  ];

  # Kernel parameters
  boot = {
    initrd = {
      availableKernelModules = ["virtio_pci" "virtio_scsi"];
      kernelModules = ["dm-snapshot"];
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];

    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };

    extraModulePackages = [];
    tmp.cleanOnBoot = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
