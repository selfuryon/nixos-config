{ inputs, pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    home.shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      gc = "git commit";
      gd = "git diff";
      ga = "git add";
      gs = "git status";
      gph = "git push";
      gl = "git ll";
      gpl = "git pull";

      nrs =
        "doas nixos-rebuild switch --flake path:/home/syakovlev/nixos-config";

      k = "kubectl";
      kx = "kubectx";
      kns = "kubens";
      ke = "kubie";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      KUBECONFIG = "~/.config/kubernetes";
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    };

    programs = {
      bat = {
        enable = true;
        config.theme = "GitHub";
      };
      exa = {
        enable = true;
        enableAliases = true;
      };
      jq.enable = true;
    };
  };
}
