{ config, pkgs, ... }: {
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
