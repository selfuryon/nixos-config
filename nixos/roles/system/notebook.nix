{
  imports = [
    # Default configuration
    ./default.nix
    # Desktop configuration
    ./suites/desktop.nix
    ./suites/libvirt.nix
    ./suites/network-manager.nix
    ./suites/pipewire.nix
    #./suites/printer.nix
  ];
}
