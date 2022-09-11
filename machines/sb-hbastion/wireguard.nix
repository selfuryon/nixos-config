{ config, ... }: {
  # Wireguard configuration
  age.secrets.wireguard.file = ../../secrets/wireguard.sb-hbastion.age;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "172.31.254.1/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.wireguard.path;

      peers = [
        { # Jumo
          publicKey = "304EB3iYwWO3+h7fRWG3CHTh6uN4SLJmVQ7uhs81PHs=";
          allowedIPs = [ "172.31.254.11/32" ];
        }
        { # Android
          publicKey = "S3eIVH4U2LISKHYOgmum7la1IILyjju8SODe5Ho8Q34=";
          allowedIPs = [ "172.31.254.12/32" ];
        }
        { # iPhone
          publicKey = "d/aaWRiVPTb+9BcTrGcHYEG93OJKKd+xvhZwF4JeH2k=";
          allowedIPs = [ "172.31.254.22/32" ];
        }
      ];
    };
  };

}
