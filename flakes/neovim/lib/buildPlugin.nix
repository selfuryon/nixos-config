{ inputs, ... }:
final: prev:
let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  plugins = builtins.filter (s: (builtins.match "plugin:.*" s) != null)
    (builtins.attrNames inputs);
  plugName = input:
    builtins.substring (builtins.stringLength "plugin:")
    (builtins.stringLength input) input;

  buildPlug = name:
    buildVimPluginFrom2Nix {
      pname = plugName name;
      version = "master";
      src = builtins.getAttr name inputs;
    };
in {
  neovimPlugins = builtins.listToAttrs (map (plugin: {
    name = plugName plugin;
    value = buildPlug plugin;
  }) plugins);
}
