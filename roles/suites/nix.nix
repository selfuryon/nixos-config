{ inputs, pkgs, ... }: {
  # Add each input as a registry
  nix.registry = pkgs.lib.mapAttrs (n: v: { flake = v; }) inputs;

  # Nix 
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "03:15";
    };
  };
}
