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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    bat.enable = true;
    jq.enable = true;
    exa.enable = true;
    exa.enableAliases = true;
  };
}
