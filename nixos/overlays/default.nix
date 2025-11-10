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
        rev = "v0.15.0"; # master branch
        hash = "sha256-yyvIjaOElEHR75o+DgVOG1EklXaWGdjvv15iMvfbkeA=";
      };
      vendorHash = "sha256-ivFw62+pg503EEpRsdGSQrFNah87RTUrRXUSPZMFLG4=";
    });
  };
}
