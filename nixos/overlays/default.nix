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
      version = "0.16.0-alpha.2";
      src = prev.fetchFromGitHub {
        owner = "cue-lang";
        repo = "cue";
        rev = "v${version}";
        hash = "sha256-0OPW5yfHX/0+mGXIsV3dort8LCNbDbi51IYytUSQdJI=";
      };
      vendorHash = "sha256-KPhwu4Z8PcXr74NEZ9+Uz7FHIMzcKqkd20FDFW+a2NA=";

    });
  };
}
