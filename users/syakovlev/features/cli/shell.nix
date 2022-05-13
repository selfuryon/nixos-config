{ pkgs, ... }: {
  home.shellAliases = {
    vim = "${pkgs.neovim}/bin/nvim";
    cat = "${pkgs.bat}/bin/bat";
    gc = "git commit";
    gd = "git diff";
    ga = "git add";
    gs = "git status";
    gph = "git push";
    gl = "git ll";
    gpl = "git pull";

    nrs = "sudo nixos-rebuild switch --flake path:/home/syakovlev/nixos-config";
    hms = "home-manager switch --flake /home/syakovlev/nixos-config";

    k = "kubectl";
    kx = "kubectx";
    kns = "kubens";
    ke = "kubie";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    KUBECONFIG = "~/.config/kubernetes";
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
}
