{
  config,
  lib,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
  ];

  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["zfs"];
      supportedFilesystems = ["zfs"];
    };

    #zfs.extraPools = [ "zroot" ];
    zfs.requestEncryptionCredentials = true;

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = ["nohibernate" "elevator=none"];
    kernelModules = ["kvm-intel" "zfs"];
    supportedFilesystems = ["zfs"];

    extraModulePackages = [];
    tmp.cleanOnBoot = true;
  };

  # Hardware configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
    ledger.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  fileSystems."/state/system".neededForBoot = true;
  fileSystems."/state/home".neededForBoot = true;
}
