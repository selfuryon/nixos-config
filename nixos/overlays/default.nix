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
        rev = "d4f9bfb3c5e4a06b58ab4dc9c5f96cf77ac79841"; # master branch
        hash = "sha256-dpNyDU7MVowRJnW3Y+1oOTxHA7tpghCxB9Md0E+b3Ms=";
      };
      vendorHash = "sha256-41YjukhiqNMrFGFuNKUewVYFQsLODDEdhuMg2GyzPsI=";
    });
  };
}
