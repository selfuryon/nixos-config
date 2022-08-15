{ ... }: {
  networking = {
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp1s0.useDHCP = false;
  };
}
