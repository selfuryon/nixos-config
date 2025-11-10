{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # ario
    mpc
    # pamixer
  ];
  services.mpd = {
    enable = true;
    musicDirectory = /home/syakovlev/data/music;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };
  services.mpdris2.enable = true;
}
