{pkgs, ...}: {
  security.pam.services.swaylock = {text = "auth include login";};

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [polkit_gnome];

  services = {
    dbus.packages = [pkgs.gcr];
  };

  programs = {
    ssh.startAgent = true;
    light.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };
}
