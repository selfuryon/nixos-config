{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) deploy-rs;

  # Load inventory
  inventory = lib.inventory.createInventory ./machines;
  roles = lib.fs.rakeLeaves ./roles;

  overlays = import ./overlays;

  # Make system configuration, given hostname and system type
  mkSystem = {
    hostname,
    system,
    users,
    ...
  }: let
    userList = builtins.map (u: ./users/${u}) users;
  in
    lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs hostname system roles;};
      modules =
        [
          {
            nixpkgs = {
              overlays = builtins.attrValues overlays;
              config = {allowUnfree = true;};
            };
          }
          ./machines/${hostname}
        ]
        ++ userList;
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
    nixosConfigurations = lib.mapAttrs (name: mkSystem) inventory;
    deploy.nodes = lib.mapAttrs (name: mkDeployNode) inventory;
  };
}
