{ config, pkgs, ... }: {

  networking = {
    #resolvconf.enable = false;
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;

    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    #networkmanager.unmanaged = [ "type:wireguard" ];
  };

}
