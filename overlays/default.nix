final: prev: {
  # Megasync with wayland support
  megasync = prev.megasync.overrideAttrs (oldAttrs: rec {
    patches = (oldAttrs.patches or [ ]) ++ [
      (builtins.fetchurl {
        url =
          "https://patch-diff.githubusercontent.com/raw/meganz/MEGAsync/pull/566.patch";
        sha256 = "0vk3vc74gbr8yz0zy6x142pagbs98wcxvdsgaqjjrxrrfjwygg4b";
      })
    ];
  });

}
