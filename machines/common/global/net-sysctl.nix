{...}: {
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
}
