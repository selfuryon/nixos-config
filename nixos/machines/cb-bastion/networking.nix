{
  networking = {
    useDHCP = false;
    interfaces.ens18.useDHCP = false;
    # IPv4 configuration
    interfaces.ens18.ipv4.addresses = [
      {
        address = "207.180.224.154";
        prefixLength = 24;
      }
    ];
    defaultGateway = "207.180.224.1";

    # IPv6 configuration
    interfaces.ens18.ipv6.addresses = [
      {
        address = "2a02:c207:2135:1181:0000:0000:0000:0001";
        prefixLength = 64;
      }
      {
        address = "fe80::250:56ff:fe4b:a6ac";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens18";
    };
  };
}
