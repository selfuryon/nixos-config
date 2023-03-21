{inputs, ...}: {
  imports = [
    inputs.self.homeManagerModules
    ./cli
    ./nvim
  ];
}
