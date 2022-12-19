{ pkgs, config, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "onelight";
        keys.normal = { space.space = "file_picker"; };
      };
    };
  };
}
