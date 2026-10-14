{ inputs, ... }:
{
  imports = [
    # provides flake.modules.<class>.<aspect>
    inputs.flake-parts.flakeModules.modules
    inputs.devshell.flakeModule
  ];

  systems = [ "x86_64-linux" ];
}
