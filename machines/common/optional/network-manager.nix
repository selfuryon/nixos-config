{ pkgs, ... }: {
  # Network Manager
  networking = {
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
    networkmanager.wifi.powersave = false;
    networkmanager.dns = "none";
  };

}
