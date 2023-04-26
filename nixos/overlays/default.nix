{
  # Adds my custom packages
  #additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    waybar =
      (
        prev.waybar.overrideAttrs (oldAttrs: {mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];})
      )
      .override {withMediaPlayer = true;};
    insomnia =
      prev.insomnia.overrideAttrs
      (_: let
        runtimeLibs = final.lib.makeLibraryPath (with final.pkgs; [curl glibc libudev0-shim nghttp2 openssl stdenv.cc.cc.lib]);
      in {
        preFixup = ''wrapProgram "$out/bin/insomnia" "''${gappsWrapperArgs[@]}" --prefix LD_LIBRARY_PATH : ${runtimeLibs} '';
      });
  };
}
