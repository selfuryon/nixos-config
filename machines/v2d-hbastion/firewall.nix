{ config, pkgs, ... }: {
  # Network Stack configuration
  boot.kernel.sysctl = {
    # Forwarding
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;

    # Ignore broadcast ICMP
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;

    # Enable reverse path filtering
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;

    # Ignore incoming ICMP redirects
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;

    # Ignore outgoing ICMP redirects
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
  };
  # Firewall
  networking = {
    firewall.enable = false;
    #firewall.package = pkgs.iptables-nftables-compat;
    nftables = {
      enable = true;
      ruleset = ''
        table inet filter {
          chain input {
            type filter hook input priority 0; policy drop;
            ct state invalid counter drop comment "early drop of invalid packets"
            ct state {established, related} counter accept comment "accept all connections related to connections made by us"
            iif lo accept comment "accept loopback"
            iif != lo ip daddr 127.0.0.1/8 counter drop comment "drop connections to loopback not coming from loopback"
            iif != lo ip6 daddr ::1/128 counter drop comment "drop connections to loopback not coming from loopback"
            ip protocol icmp counter accept comment "accept all ICMP types"
            ip6 nexthdr icmpv6 counter accept comment "accept all ICMP types"
            tcp dport 22 counter accept comment "accept SSH"
            udp dport 51820 counter accept comment "accept Wireguard"
            counter comment "count dropped packets"
          }

          chain forward {
            type filter hook forward priority 0; policy drop;
            ct state invalid counter drop comment "early drop of invalid packets"
            ct state {established, related} counter accept comment "accept all connections related to connections made by us"
            iifname "wg0" counter accept comment "accept wireguard"
            counter comment "count dropped packets"
          }

          chain postrouting {
            type nat hook postrouting priority 100; policy accept;
            oifname "ens3" counter masquerade comment "NAT all traffic"
          }

          chain output {
            type filter hook output priority 0; policy accept;
            counter comment "count accepted packets"
          }

        }
      '';
    };
  };

}
