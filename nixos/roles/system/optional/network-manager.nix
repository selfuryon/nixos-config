{pkgs, ...}: {
  # Network Manager
  networking.networkmanager = {
    enable = true;
    dns = "none";
    plugins = with pkgs; [networkmanager-openvpn];
    wifi.powersave = false;
  };
}
