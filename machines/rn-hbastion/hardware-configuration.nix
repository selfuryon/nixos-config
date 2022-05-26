{ modulesPath, ... }: {

  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.kernelModules = [ "nvme" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  swapDevices = [{ device = "/dev/vda2"; }];
}
