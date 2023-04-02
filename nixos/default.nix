{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (lib) fs filterAttrs hasSuffix mapAttrs' nameValuePair head splitString;

  roles = fs.rakeLeaves ./roles;
  users = fs.rakeLeaves ./users;
  machines = fs.flattenTree {tree = fs.rakeLeaves ./machines;};

  inventory = let
    hosts = filterAttrs (_: hasSuffix "default.nix") machines;
  in
    mapAttrs' (name: nameValuePair (head (splitString "." name))) hosts;

  overlays = import ./overlays;

  # nixosConfigurations default modules
  defaultModules = [
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.ragenix.nixosModules.age
      ];
      nixpkgs = {
        overlays = builtins.attrValues overlays;
        config = {allowUnfree = true;};
      };
    }
  ];

  # colmena meta
  colmenaMeta = {
    meta = {
      description = "My NixOS machines";
      nixpkgs = import inputs.nixpkgs {system = "x86_64-linux";};
      specialArgs = {inherit inputs roles users;};
    };
  };

  # Make system configuration
  mkSystem = _: path:
    lib.nixosSystem {
      specialArgs = {inherit inputs roles users;};
      modules = defaultModules ++ [path];
      extraModules = [inputs.colmena.nixosModules.deploymentOptions];
    };

  # Make colmena configuration
  mkColmenaNodes = builtins.mapAttrs (name: value: {
    nixpkgs.system = value.config.nixpkgs.system;
    imports = value._module.args.modules;
  });
in {
  flake = {
    homeManagerModules = import ./modules/homeManager;
    nixosConfigurations = lib.mapAttrs mkSystem inventory;
    colmena = colmenaMeta // (mkColmenaNodes self.nixosConfigurations);
  };
}
