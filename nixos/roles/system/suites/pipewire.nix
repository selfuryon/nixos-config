{pkgs, ...}: {
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  xdg.portal = {
    enable = true;
    configPackages = [pkgs.xdg-desktop-portal-gnome];
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    #extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
