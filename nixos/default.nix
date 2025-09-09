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
        # inputs.ragenix.nixosModules.age
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
      # extraModules = [inputs.colmena.nixosModules.deploymentOptions];
    };
  # mkColmenaNodes = conf:
  #   {
  #     meta = {
  #       description = "My personal machines";
  #       nixpkgs = import inputs.nixpkgs {system = "x86_64-linux";};
  #       nodeNixpkgs = builtins.mapAttrs (_: value: value.pkgs) conf;
  #       nodeSpecialArgs = builtins.mapAttrs (_: value: value._module.specialArgs) conf;
  #     };
  #   }
  #   // builtins.mapAttrs (_: value: {imports = value._module.args.modules;}) conf;
in
{
  flake = {
    homeManagerModules = import ./modules/homeManager;
    overlays = import ./overlays;
    nixosConfigurations = lib.mapAttrs mkSystem inventory;
    # colmena = mkColmenaNodes self.nixosConfigurations;
  };
}
