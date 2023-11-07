{pkgs, ...}: {
  home.shellAliases = {
    # Git
    gc = "${pkgs.git}/bin/git commit";
    gd = "${pkgs.git}/bin/git diff";
    ga = "${pkgs.git}/bin/git add";
    gs = "${pkgs.git}/bin/git status";
    gph = "${pkgs.git}/bin/git push";
    gl = "${pkgs.git}/bin/git ll";
    gpl = "${pkgs.git}/bin/git pull";
    lg = "${pkgs.lazygit}/bin/lazygit";

    # Nix
    nrs = "doas nixos-rebuild switch --flake path:/home/syakovlev/nixos-config";
    nfu = "nix flake update";
    nrb = "doas nixos-rebuild build --flake path:/home/syakovlev/nixos-config";

    # Kubernetes
    k = "kubectl";
    kx = "kubectx";
    kns = "kubens";
    tf = "terraform";
    tg = "terragrunt";

    # Other
    cat = "${pkgs.bat}/bin/bat --paging=never --style=plain";
    ip = "ip --color --brief";
    less = "${pkgs.bat}/bin/bat --paging=always";
    more = "${pkgs.bat}/bin/bat --paging=always";
    tree = "${pkgs.eza}/bin/eza --tree";
    wget = "${pkgs.wget2}/bin/wget2";
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
      extraPackages = with pkgs.bat-extras; [
        batwatch
        prettybat
      ];
    };
    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
    broot = {
      enable = true;
      settings.modal = true;
    };
    jq.enable = true;
  };
}
