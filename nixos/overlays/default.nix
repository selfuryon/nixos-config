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
    # ledger-live-test = prev.ledger-live-desktop.overrideAttrs (_: {
    #     pname = "ledger-live-desktop";
    #     version = "2.57.0";
    #     src = final.fetchurl {
    #       url = "https://download.live.ledger.com/ledger-live-desktop-2.57.0-linux-x86_64.AppImage";
    #       hash = "sha256-fXvCj9eBEp/kGPSiNUdir19eU0x461KzXgl5YgeapHI=";
    #     };
    #   });
  };
}
