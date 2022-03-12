{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

}
