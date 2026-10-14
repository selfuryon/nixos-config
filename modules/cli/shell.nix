{
  flake.modules.homeManager.cli =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
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
        nrs = "doas nixos-rebuild switch --flake path:${config.home.homeDirectory}/src/personal/nixos-config";
        nrb = "doas nixos-rebuild build --flake path:${config.home.homeDirectory}/src/personal/nixos-config";
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
        # wget = "${pkgs.wget2}/bin/wget2";
      };

      home.sessionVariables = {
        # nushell envs: nixos/roles/user/terminal/cli/nushell.nix
        EDITOR = "hx";
        SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
        KUBECONFIG = "${config.xdg.configHome}/kubernetes";
        CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
      };

      my.persist.directories = [
        ".local/share/atuin"
        ".local/share/zoxide"
      ];

      programs = {
        zoxide.enable = true;
        carapace = {
          enable = true;
          enableNushellIntegration = true;
        };
        atuin = {
          enable = true;
          enableFishIntegration = true;
          # Integration is wired up manually below: atuin's own init script registers
          # both its Ctrl-R and Up keybindings under the name `atuin`, and nushell
          # >= 0.115 warns on every startup that multiple keybindings share a name.
          enableNushellIntegration = false;
          settings = {
            style = "compact";
            # "skim" was removed in atuin 18.x; "daemon-fuzzy" needs the atuin daemon
            search_mode = "fuzzy";
          };
        };
        yazi = {
          enable = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
        };
        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [
            batwatch
            prettybat
          ];
        };
        eza = {
          enable = false;
          enableFishIntegration = true;
          #enableNushellIntegration = true;
        };
        broot = {
          enable = true;
          settings = {
            imports = lib.mkForce [
              "verbs.hjson"
              "skins/native-16.hjson"
            ];
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
          };
        };
        jq.enable = true;
      };
    };
}
