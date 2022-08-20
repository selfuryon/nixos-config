{ inputs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    home.packages = [ inputs.neovimSY.defaultPackage.x86_64-linux ];
  };
}
