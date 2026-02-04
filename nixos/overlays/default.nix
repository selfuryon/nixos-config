{
  # Adds my custom packages
  #additions = final: _prev: import ../pkgs { pkgs = final; };

  # modifications = _final: prev: {
  #   waybar =
  #     (
  #       prev.waybar.overrideAttrs (oldAttrs: {mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];})
  #     )
  #     .override {withMediaPlayer = true;};
  # };
  cue = _: prev: {
    cue-master = prev.cue.overrideAttrs (_: rec {
      version = "0.16.0-alpha.1";
      src = prev.fetchFromGitHub {
        owner = "cue-lang";
        repo = "cue";
        rev = "v${version}";
        hash = "sha256-V6U8/b4e+2oULOiEC9oMSYF2ytd/1wMRbxA0Oq6Il74=";
      };
      vendorHash = "sha256-ojUHe3AxblAaLwaB+GmxCie1AywHFnGnMyhwTw7RBsw=";
    });
  };
}
