{
  inputs,
  pkgs,
  ...
}: {
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
    #wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #inputs.xdph.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      (inputs.xdph.packages.${pkgs.system}.xdg-desktop-portal-hyprland.override {
        hyprland-share-picker = inputs.xdph.packages.${pkgs.system}.hyprland-share-picker.override {
          inherit (inputs) hypland;
        };
      })
    ];
  };
}
