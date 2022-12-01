{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ podman-compose ];
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
