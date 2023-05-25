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

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [];

    loader.grub = {
      enable = true;
      device = "/dev/vda";
    };

    extraModulePackages = [];
    tmp.cleanOnBoot = true;
  };
  zramSwap.enable = false;

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  swapDevices = [{device = "/dev/vda2";}];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
