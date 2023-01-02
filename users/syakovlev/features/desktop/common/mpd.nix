{ pkgs, ... }: {
  home.packages = with pkgs; [ ario mpc_cli pamixer ];
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

}
