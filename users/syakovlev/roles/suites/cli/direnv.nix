{ ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
