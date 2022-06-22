{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
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

    home.packages = with pkgs; [ ario mpc_cli pamixer ];
  };
}
