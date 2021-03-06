{ modulesPath, pkgs, ... }: {

  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  # Kernel parameters
  boot = {
    initrd.kernelModules = [ "nvme" ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ ];

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };

    extraModulePackages = [ ];
    cleanTmpDir = true;
  };
  zramSwap.enable = false;

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  swapDevices = [{ device = "/dev/vda2"; }];
}
