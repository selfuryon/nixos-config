{ config, pkgs, ... }: {
  # DNS
  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [ "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md" ];
        cache_file = "public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
      };
    };
  };
}
