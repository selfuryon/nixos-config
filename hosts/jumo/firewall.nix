{ config, pkgs, ... }: {
  # Forwarding
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
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
            counter comment "count dropped packets"
          }

          chain forward {
            type filter hook forward priority 0; policy drop;
            ct state invalid counter drop comment "early drop of invalid packets"
            ct state {established, related} counter accept comment "accept all connections related to connections made by us"
            iifname "virbr0" counter accept comment "accept kvm"
            counter comment "count dropped packets"
          }

          chain postrouting {
            type nat hook postrouting priority 100; policy accept;
            oifname "wlp5s0" counter masquerade comment "NAT all traffic"
            oifname "enp4s0" counter masquerade comment "NAT all traffic"
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
