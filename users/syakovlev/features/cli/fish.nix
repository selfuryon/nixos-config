{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.programs.fish = {
    enable = true;
    plugins = [{
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "45a9ff6d0932b0e9835cbeb60b9794ba706eef10";
        hash = "sha256-pWkEhjbcxXduyKz1mAFo90IuQdX7R8bLCQgb0R+hXs4=";
      };
    }];
    shellAliases = {
      # Get ip
      getip = "curl ifconfig.me";
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    loginShellInit = ''
      if test (tty) = /dev/tty1
        systemd-cat -t sway ${pkgs.sway}/bin/sway
      end
    '';
  };
}
