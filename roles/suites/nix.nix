{ inputs, pkgs, ... }: {
  # Add each input as a registry
  nix.registry = pkgs.lib.mapAttrs (n: v: { flake = v; }) inputs;

  # Nix 
  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [ "root" "@wheel" ];
    };
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "03:15";
    };
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
