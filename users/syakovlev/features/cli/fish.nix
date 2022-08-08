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
      if status is-interactive; and set -q SSH_TTY;
        set ZELLIJ_AUTO_ATTACH true
        set ZELLIJ_AUTO_EXIT true
        eval (zellij setup --generate-auto-start fish | string collect)
      end
    '';
  };
}
