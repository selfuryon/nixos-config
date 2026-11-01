{ inputs, ... }:
{
  flake.modules.nixos.nemda =
    {
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
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
          availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ "zfs" ];
          supportedFilesystems = [ "zfs" ];
        };
        zfs.requestEncryptionCredentials = true;
        zfs.forceImportRoot = false;

        #kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
        # kernelPackages = pkgs.linuxPackages_latest;
        # kernelPackages = pkgs.linuxPackages_6_6;
        # tuxedo-drivers 4.20.1 re-runs make with an explicit $(MAKEFLAGS) on the
        # shell command line, which breaks on the `cmd_sign=...$(space)$@` flag
        # nixpkgs now passes to kernel modules. The sub-make already inherits
        # MAKEFLAGS through the environment, so drop the explicit copy. Its
        # modules_install also runs depmod into $out; those modules.* indexes
        # collide with the kernel's in the system module tree, so drop them.
        kernelPackages = pkgs.linuxPackages.extend (
          _: prev: {
            tuxedo-drivers = prev.tuxedo-drivers.overrideAttrs (old: {
              postPatch = (old.postPatch or "") + ''
                substituteInPlace Makefile --replace-fail ' $(MAKEFLAGS)' ""
              '';
              postInstall = (old.postInstall or "") + ''
                rm -f $out/lib/modules/*/modules.*
              '';
            });
          }
        );
        kernelParams = [
          "nohibernate"
          "elevator=none"
        ];
        kernelModules = [
          "kvm-intel"
          "zfs"
        ];
        supportedFilesystems = [ "zfs" ];

        extraModulePackages = [ ];
        tmp.cleanOnBoot = true;

        # Blacklist broken audio codec modules (ALC256 causes unexpected shutdowns)
        blacklistedKernelModules = [
          "snd_hda_intel"
          "snd_sof"
          "snd_sof_pci"
          "snd_sof_pci_intel_tgl"
          "snd_sof_pci_intel_cnl"
          "snd_sof_intel_hda_common"
          "snd_sof_intel_hda_generic"
        ];
      };

      # Hardware configuration
      hardware = {
        graphics.enable = true;
        cpu.intel.updateMicrocode = true;
        bluetooth.enable = true;
        ledger.enable = true;
        #tuxedo-keyboard.enable = true;
        keyboard.zsa.enable = true;
        tuxedo-rs.enable = true;
        tuxedo-rs.tailor-gui.enable = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    };
}
