_: {
  users.groups.ssh = {};
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;
}
