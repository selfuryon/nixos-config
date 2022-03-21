{ pkgs, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = ~/data/music;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };

  home.packages = with pkgs; [ ario mpc_cli ];
}
