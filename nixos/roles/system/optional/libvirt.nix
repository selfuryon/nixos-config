{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [virtiofsd];
}
