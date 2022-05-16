{ config, pkgs, ... }: {

  networking = {
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;
  };

}
