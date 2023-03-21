{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) deploy-rs;
  inherit (lib) fs filterAttrs hasSuffix mapAttrs' nameValuePair head splitString;

  roles = fs.rakeLeaves ./roles;
  users = fs.rakeLeaves ./users;
  machines = fs.flattenTree {tree = fs.rakeLeaves ./machines;};

  inventory = let
    hosts = filterAttrs (_: hasSuffix "default.nix") machines;
  in
    mapAttrs' (name: nameValuePair (head (splitString "." name))) hosts;

  deployInventory = lib.inventory.createInventory ./machines;

  overlays = import ./overlays;
  defaultModules = [
    {
      nixpkgs = {
        overlays = builtins.attrValues overlays;
        config = {allowUnfree = true;};
      };
    }
  ];

  # Make system configuration
  mkSystem = hostname: path:
    lib.nixosSystem {
      specialArgs = {inherit inputs hostname roles users;};
      modules = defaultModules ++ [path];
    };

  # Make Deploy-rs node
  mkDeployNode = {
    hostname,
    system,
    sshUser,
    sudo ? "sudo -u",
    ...
  }: {
    hostname = "${hostname}";
    sshUser = "${sshUser}";
    sudo = "${sudo}";
    profilesOrder = ["system"];
    profiles = {
      system = {
        user = "root";
        path =
          deploy-rs.lib."${system}".activate.nixos
          self.nixosConfigurations.${hostname};
      };
    };
  };
in {
  flake = {
    homeManagerModules = import ./modules/homeManager;
    nixosConfigurations = lib.mapAttrs mkSystem inventory;
    deploy.nodes = lib.mapAttrs (name: mkDeployNode) deployInventory;
  };
}
