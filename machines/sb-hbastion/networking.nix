{...}: {
  networking = {
    useDHCP = false;
    interfaces.ens3.useDHCP = false;

    # IPv4 configuration
    interfaces.ens3.ipv4.addresses = [
      {
        address = "185.251.89.102";
        prefixLength = 22;
      }
    ];
    defaultGateway = "185.251.88.1";

    # IPv6 configuration
    interfaces.ens3.ipv6.addresses = [
      {
        address = "2a0a:2b41:b:f2da::";
        prefixLength = 64;
      }
      {
        address = "fe80::5054:ff:fe0c:c9ba";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
  };
}
