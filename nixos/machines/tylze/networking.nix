{
  # age.secrets.cyhome.file = ../../secrets/wireless.cyhome.age;
  networking = {
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp1s0.useDHCP = false;
    # wireless = {
    #   enable = true;
    #   interfaces = ["wlp1s0"];
    #   environmentFile = config.age.secrets.cyhome.path;
    #   networks."CYHome 5Ghz" = {
    #     authProtocols = ["SAE"];
    #     auth = ''
    #       ieee80211w=2
    #       sae_password="@SAE_PASSWORD@"
    #     '';
    #   };
    # };
  };
}
