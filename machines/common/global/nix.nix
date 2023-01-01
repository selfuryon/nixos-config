{ inputs, config, pkgs, lib, ... }: {
  # Nix 
  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [ "root" "@wheel" ];
    };
    extraOptions = "experimental-features = nix-command flakes repl-flake";
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # Map nixpkgs to /etc/nixpkgs
  environment.etc.nixpkgs.source = inputs.nixpkgs;

  # Add each input as a registry
  nix.registry = pkgs.lib.mapAttrs (_: v: { flake = v; }) inputs;
}
