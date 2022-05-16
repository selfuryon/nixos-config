{ inputs, ... }: {
  # Network Manager
  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
  };

}
