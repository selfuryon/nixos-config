{ pkgs, ... }: {
  home.shellAliases = {
    vim = "${pkgs.neovim}/bin/nvim";
    cat = "${pkgs.bat}/bin/bat";
    gc  = "git commit";
    gd  = "git diff";
    ga  = "git add";
    gs  = "git status";
    gph = "git push";
    gl  = "git ll";
    gpl = "git pull";

    nrs = "sudo nixos-rebuild switch --flake /home/syakovlev/nixos-config";
    hms = "home-manager switch --flake /home/syakovlev/nixos-config";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
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
