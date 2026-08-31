{
  pkgs,
  lib,
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
      # Nushell 0.115 deduplicates `$env.config.keybindings` by `name`, and atuin's
      # init script registers both its Ctrl-R and Up bindings as `atuin`; the Up one
      # silently drops the Ctrl-R one, leaving nushell's builtin `history_menu` on
      # Ctrl-R. Re-add the atuin search binding under its own name, ordered past
      # atuin's own snippet (mkOrder 2000) so `_atuin_search_cmd` is defined.
      extraConfig = lib.mkOrder 2500 ''
        $env.config.keybindings = (
          $env.config.keybindings | append {
            name: atuin_search
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: executehostcommand cmd: (_atuin_search_cmd) }
          }
        )
      '';
      envFile.text = ''
        $env.EDITOR = "hx"
        $env.CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
        $env.KUBECONFIG = "${config.xdg.configHome}/kubernetes"
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
        zj = "${pkgs.zellij}/bin/zellij";
        zjs = "${pkgs.zellij}/bin/zellij -s";
        zja = "${pkgs.zellij}/bin/zellij a";

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
