{
  users.groups.ssh = { };
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.sshAgentAuth.enable = true;
}
