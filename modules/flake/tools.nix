{
  perSystem = {
    devshells.default.commands = [
      {
        category = "Tools";
        name = "fmt";
        help = "Format the source tree";
        command = "nix fmt";
      }
      {
        category = "Tools";
        name = "check";
        help = "Nix flake check";
        command = "nix flake check";
      }
    ];
  };
}
