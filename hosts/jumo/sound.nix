{ config, pkgs, ... }: {
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
      unload-module module-suspend-on-idle
    '';
  };
}
