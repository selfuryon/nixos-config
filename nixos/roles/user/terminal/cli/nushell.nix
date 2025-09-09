{
  pkgs,
  config,
  ...
}:
{
  programs = {
    nushell = {
      enable = true;
      configFile.text = ''
        $env.config = {
         edit_mode: vi
         show_banner: false,
         completions: {
           algorithm: "fuzzy"    # prefix or fuzzy
         }
        }
      '';
      envFile.text = ''
        $env.EDITOR = "hx"
        $env.KUBECONFIG = "/home/syakovlev/.config/kubernetes"
        $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent"
        $env.GNUPGHOME = "${config.xdg.dataHome}/gnupg"
      '';
      shellAliases = {
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
        #tree = "${pkgs.eza}/bin/eza --tree";
        #wget = "${pkgs.wget2}/bin/wget2";
        nano = "${pkgs.helix}/bin/hx";
      };
    };
  };
}
