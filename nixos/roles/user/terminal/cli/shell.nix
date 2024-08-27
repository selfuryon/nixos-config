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
    nrs = "doas nixos-rebuild switch --flake path:/home/syakovlev/src/personal/nixos-config";
    nrb = "doas nixos-rebuild build --flake path:/home/syakovlev/src/personal/nixos-config";
    nfu = "nix flake update";

    # Kubernetes
    k = "kubectl";
    kx = "kubectx";
    kns = "kubens";
    tf = "terraform";
    tg = "terragrunt";

    # Other
    cat = "${pkgs.bat}/bin/bat --paging=never --style=plain";
    ip = "ip --color --brief";
    # less = "${pkgs.tailspin}/bin/tspin";
    more = "${pkgs.bat}/bin/bat --paging=always";
    tree = "${pkgs.eza}/bin/eza --tree";
    wget = "${pkgs.wget2}/bin/wget2";
  };

  home.sessionVariables = {
    EDITOR = "hx";
    KUBECONFIG = "/home/syakovlev/.config/kubernetes";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

  programs = {
    zoxide.enable = true;
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    atuin = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      settings = {
        style = "compact";
        search_mode = "skim";
      };
    };
    yazi = {
      enable = true;
      catppuccin.enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    bat = {
      enable = true;
      catppuccin.enable = true;
      extraPackages = with pkgs.bat-extras; [
        batwatch
        prettybat
      ];
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      #enableNushellIntegration = true;
      icons = true;
    };
    broot = {
      enable = true;
      settings = {
        modal = false;
        verbs = [
          {
            invocation = "zellij-edit";
            key = "enter";
            execution = "zellij edit {file}";
            working_dir = "{root}";
            leave_broot = false;
            apply_to = "text_file";
          }
        ];
        skins = {
          status_normal_fg = "grayscale(18)";
          status_normal_bg = "grayscale(3)";
          status_error_fg = "red";
          status_error_bg = "yellow";
          tree_fg = "red";
          selected_line_bg = "grayscale(7)";
          permissions_fg = "grayscale(12)";
          size_bar_full_bg = "red";
          size_bar_void_bg = "black";
          directory_fg = "lightyellow";
          input_fg = "cyan";
          flag_value_fg = "lightyellow";
          table_border_fg = "red";
          code_fg = "lightyellow";
        };
      };
    };
    jq.enable = true;
  };
}
