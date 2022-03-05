{ pkgs, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = ~/data/music;
    extraConfig = ''
      audio_output {
        type "pulse" # MPD must use Pulseaudio
        name "Pulseaudio" # Whatever you want
        server "127.0.0.1" # MPD must connect to the local sound server
      }
    '';
  };

  home.packages = with pkgs; [ ario mpc_cli ];
}
