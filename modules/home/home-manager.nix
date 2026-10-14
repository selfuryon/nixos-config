{ inputs, config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      # Options every user's config may set (my.persist, fontProfile, theme).
      sharedModules = [ homeManager.base ];
    };
  };

  flake.modules.homeManager.base.programs.home-manager.enable = true;
}
