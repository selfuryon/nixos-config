{
  self,
  inputs,
  lib,
  ...
}:
let
  inherit (lib)
    fs
    filterAttrs
    hasSuffix
    mapAttrs'
    nameValuePair
    head
    splitString
    ;

  roles = fs.rakeLeaves ./roles;
  users = fs.rakeLeaves ./users;
  machines = fs.flattenTree { tree = fs.rakeLeaves ./machines; };

  inventory =
    let
      hosts = filterAttrs (_: hasSuffix "default.nix") machines;
    in
    mapAttrs' (name: nameValuePair (head (splitString "." name))) hosts;

  # nixosConfigurations default modules
  defaultModules = [
    {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
        inputs.home-manager.nixosModules.home-manager
        inputs.dank-greeter.nixosModules.default
      ];
      # home-manager modules available to every user; they only declare
      # options, so importing them is free until something enables them.
      home-manager.sharedModules = [
        self.homeManagerModules
        inputs.catppuccin.homeModules.catppuccin
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
        inputs.base16.homeManagerModule
        inputs.niri.homeModules.niri
      ];
    }
  ];

  # Make system configuration
  mkSystem =
    _: path:
    lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          roles
          users
          self
          ;
      };
      modules = defaultModules ++ [ path ];
    };
in
{
  flake = {
    homeManagerModules = import ./modules/homeManager;
    nixosConfigurations = lib.mapAttrs mkSystem inventory;
  };
}
