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
        rev = "f5454200d80ac6941038b0de1de2770f241d2832"; # master branch
        hash = "sha256-RrK+UO0ARX3Z0w/jVlJnetz2CFe4s8SmrmNr4C8NQQw=";
      };
      vendorHash = "sha256-41YjukhiqNMrFGFuNKUewVYFQsLODDEdhuMg2GyzPsI=";
    });
  };
}
