{
  flake.modules.homeManager.desktop =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        # ario
        mpc
        # pamixer
      ];
      services.mpd = {
        enable = true;
        musicDirectory = "${config.home.homeDirectory}/data/music";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire Output"
          }
        '';
      };
      services.mpdris2.enable = true;
    };
}
