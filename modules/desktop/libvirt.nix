{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      networking.firewall.trustedInterfaces = [ "virbr0" ];
      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
}
