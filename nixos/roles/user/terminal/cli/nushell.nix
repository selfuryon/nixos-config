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
      # Manual replacement for `programs.atuin.enableNushellIntegration`, which
      # sources atuin's init script verbatim. That script registers both its
      # Ctrl-R and its Up keybinding under the name `atuin`, and nushell >= 0.115
      # warns about shared keybinding names on every startup. Give every binding
      # past the first a unique name. mkOrder 2000 matches home-manager, so the
      # script still lands after fzf and keeps Ctrl-R.
      extraConfig = lib.mkOrder 2000 ''
        source ${
          pkgs.runCommand "atuin-nushell-config.nu"
            {
              nativeBuildInputs = [ pkgs.writableTmpDirAsHomeHook ];
            }
            ''
              ${lib.getExe config.programs.atuin.package} init nu \
                | awk '{ if ($0 ~ /^ *name: atuin$/) { n++; if (n > 1) sub(/name: atuin$/, "name: atuin_" n) } print }' \
                > "$out"
            ''
        }
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
