{ pkgs, ... }: {
  users.users.syakovlev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" ];
    shell = pkgs.zsh;
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

    fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };
  security.pam.services.swaylock = { };
}
