{
  flake.modules.nixos.printer = {
    services = {
      printing.enable = true;
      avahi.enable = true;
      avahi.openFirewall = true;
    };
  };
}
