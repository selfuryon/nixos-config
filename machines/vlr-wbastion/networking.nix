{...}: {
  networking = {
    useDHCP = false;
    interfaces.enp1s0.useDHCP = true;
  };
}
