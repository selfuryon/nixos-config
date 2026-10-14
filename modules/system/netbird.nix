{
  flake.modules.nixos.netbird =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      services.netbird.enable = true;
    };
}
