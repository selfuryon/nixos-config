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
      nixpkgs = {
        overlays = builtins.attrValues overlays;
        config = {allowUnfree = true;};
      };
    }
  ];

  # colmena meta
  colmenaMeta = {
    meta = {
      description = "My personal machines";
      nixpkgs = import inputs.nixpkgs {system = "x86_64-linux";};
      specialArgs = let hostname = "rn-hbastion"; in {inherit inputs hostname roles users;};
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
  # # Make Deploy-rs node
  # mkDeployNode = {
  #   hostname,
  #   system,
  #   sshUser,
  #   sudo ? "sudo -u",
  #   ...
  # }: {
  #   hostname = "${hostname}";
  #   sshUser = "${sshUser}";
  #   sudo = "${sudo}";
  #   profilesOrder = ["system"];
  #   profiles = {
  #     system = {
  #       user = "root";
  #       path =
  #         deploy-rs.lib."${system}".activate.nixos
  #         self.nixosConfigurations.${hostname};
  #     };
  #   };
  # };
in {
  flake = {
    homeManagerModules = import ./modules/homeManager;
    nixosConfigurations = lib.mapAttrs mkSystem inventory;
    #deploy.nodes = lib.mapAttrs (name: mkDeployNode) deployInventory;
    colmena = colmenaMeta // (mkColmenaNodes self.nixosConfigurations);
  };
}
