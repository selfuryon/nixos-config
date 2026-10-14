{ inputs, ... }:
let
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "latte";
    accent = "blue";
  };
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.catppuccin.nixosModules.catppuccin ];
    inherit catppuccin;
  };

  flake.modules.homeManager.base = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
      inputs.base16.homeManagerModule
    ];
    catppuccin = catppuccin // {
      gtk.icon.enable = false;
    };
    scheme = "${inputs.tt-schemes}/base16/catppuccin-latte.yaml";
  };
}
