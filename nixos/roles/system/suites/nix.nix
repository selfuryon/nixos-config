{
  inputs,
  lib,
  ...
}:
{
  # Map nixpkgs to /etc/nixpkgs
  environment.etc.nixpkgs.source = inputs.nixpkgs;
  # Map flake to /etc/self
  environment.etc.self.source = inputs.self;

  # Nix
  nix = {
    # package = pkgs.nixVersions.nix_2_30;
    settings = {
      extra-substituters = [
        "https://niri.cachix.org"
        # sofka has no nixConfig of its own; its release CI pushes here.
        "https://nkl-sofka.cachix.org"
      ];
      trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://colmena.cachix.org"
        "https://niri.cachix.org"
        "https://nkl-sofka.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nkl-sofka.cachix.org-1:hLg9frFNJynrxe7SSBb/p6pbawlpZmG10bw+wLsTufw="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      netrc-file = "/etc/nix/netrc";
      extra-sandbox-paths = [ "/etc/nix/netrc" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
    # Add each input as a registry
    registry = lib.mapAttrs (_: v: { flake = v; }) inputs;
    # Allow to use old nix commands with channel
    nixPath = lib.mkForce [ "nixpkgs=/etc/nixpkgs" ];
  };
}
