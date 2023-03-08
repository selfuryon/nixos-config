_: {
  networking = {
    useDHCP = false;
    interfaces.ens3.useDHCP = true;

    # IPv6 static conf
    interfaces.ens3.ipv6.addresses = [
      {
        address = "2a0b:7140:0:101:185:158:251:219";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "2a0b:7140:0:101::1";
      interface = "ens3";
    };
  };
}
