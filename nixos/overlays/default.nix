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
    cue-master = prev.cue.overrideAttrs (_: {
      src = prev.fetchFromGitHub {
        owner = "cue-lang";
        repo = "cue";
        rev = "139b17aa44444936b2598bdb3b5116b810db8096"; # master branch
        hash = "sha256-dpNyDU7MVowRJnW3Y+1oOTxHA7tpghCxB9Md0E+b3Ms=";
      };
      vendorHash = "sha256-41YjukhiqNMrFGFuNKUewVYFQsLODDEdhuMg2GyzPsI=";
    });
  };
}
