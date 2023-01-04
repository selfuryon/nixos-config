{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ podman-compose ];
  virtualisation.podman = {
    enable = true;
    extraPackages = [ pkgs.zfs ];
    dockerCompat = true;
    defaultNetwork.dnsname.enable = true;
  };
}
