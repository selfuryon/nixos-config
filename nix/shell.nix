{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: let
    inherit (pkgs) statix;
    inherit (inputs'.ragenix.packages) ragenix;
    inherit (inputs'.colmena.packages) colmena;
  in {
    devshells.default = {
      name = "personal";
      packages = [
        statix
        ragenix
        colmena
      ];
    };
  };
}
