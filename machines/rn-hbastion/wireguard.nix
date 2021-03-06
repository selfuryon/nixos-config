{ config, ... }: {
  # Wireguard configuration
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "172.31.253.1/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.rn-wireguard.path;

      peers = [
        { # Jumo
          publicKey = "304EB3iYwWO3+h7fRWG3CHTh6uN4SLJmVQ7uhs81PHs=";
          allowedIPs = [ "172.31.253.11/32" ];
        }
        { # Android
          publicKey = "S3eIVH4U2LISKHYOgmum7la1IILyjju8SODe5Ho8Q34=";
          allowedIPs = [ "172.31.253.12/32" ];
        }
        { # iPhone
          publicKey = "d/aaWRiVPTb+9BcTrGcHYEG93OJKKd+xvhZwF4JeH2k=";
          allowedIPs = [ "172.31.253.22/32" ];
        }
      ];
    };
  };

}
