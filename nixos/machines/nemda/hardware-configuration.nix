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
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Boot configuration
  boot = {
    loader = {
      # lanzaboote replace it
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["zfs"];
      supportedFilesystems = ["zfs"];
    };
    zfs.requestEncryptionCredentials = true;

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      "nohibernate"
      "elevator=none"
    ];
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
    tuxedo-keyboard.enable = true;
    tuxedo-rs.enable = true;
    tuxedo-rs.tailor-gui.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
