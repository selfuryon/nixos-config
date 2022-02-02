{ pkgs, ... }: {
  users.users.syakovlev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" ];
    shell = pkgs.fish;
  };

  programs = {
    firejail.enable = true;
    light.enable = true;
    qt5ct.enable = true;

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [];
    };
  };
  security.pam.services.swaylock = { };
}
