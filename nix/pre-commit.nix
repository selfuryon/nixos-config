{ inputs, ... }:
{
  imports = [
    inputs.pre-commit-hooks-nix.flakeModule
  ];

  perSystem = {
    pre-commit.settings = {
      excludes = [ "flake.lock" ];
      hooks = {
        nixfmt-rfc-style.enable = true;
        prettier.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };
  };
}
