{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  # Wireguard configuration
  # networking.wireguard.interfaces = {
  # wg0 = {
  # ips = [ "172.31.255.11/24" ];
  # listenPort = 51820;
  # privateKeyFile = "/etc/wireguard/keys/private";

  # peers = [{ # v2d-hbastion
  # publicKey = "5UnD8LKraFEd6ecdKIL/QFhPzWRU0+xqN1bkoLYSpkc=";
  # allowedIPs = [ "0.0.0.0/0" ];
  # endpoint = "host:port";
  # persistentKeepalive = 30;
  # }];
  # };
  # };

  # # Disale automatic start wireguard tunnel
  # systemd.services.wireguard-wg0.wantedBy = lib.mkForce [ ];
}
