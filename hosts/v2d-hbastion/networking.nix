{ config, pkgs, ... }: {
  networking = {
    useDHCP = false;
    interfaces.ens3.useDHCP = true;
  };

}
