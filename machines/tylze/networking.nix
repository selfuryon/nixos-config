{ config, ... }: {
  networking = {
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp1s0.useDHCP = false;
    wireless = {
      enable = true;
      interfaces = [ "wlp1s0" ];
      environmentFile = config.age.secrets.tylze-wireless.path;
      networks."CYHome 5Ghz" = {
        authProtocols = [ "SAE" ];
        auth = ''
          ieee80211w=2
          sae_password="@SAE_PASSWORD@"
        '';
      };
    };
    
    # IPv4 configuration
    interfaces.wlp1s0.ipv4.addresses = [{
      address = "192.168.0.2";
      prefixLength = 24;
    }];
    interfaces.enp2s0.ipv4.addresses = [{
      address = "192.168.0.3";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.0.1";

  };
}
