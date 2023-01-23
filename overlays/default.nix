{
  # Adds my custom packages
  #additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    waybar =
      (prev.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
      .override {withMediaPlayer = true;};
  };
}
