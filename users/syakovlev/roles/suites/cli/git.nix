{ ... }:
let userName = "syakovlev";
in {
  # Git configuration

  home-manager.users.${userName} = {
    home.file.".ssh/allowed_signers".text = ''
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmB+ZN4UTQ+5IOvGrlBoHrCxfpQH7EWtLNR3qUrnQl5 selfuryon@github [private]
    '';
    programs.git = {
      enable = true;
      userName = "Sergey Yakovlev";
      userEmail = "selfuryon@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      signing = {
        signByDefault = true;
        key = "~/.ssh/keys/private/github.pub";
      };
      delta = {
        enable = true;
        options = {
          light = true;
          theme = "Github";
          features = "decoration";
          whitespace-error-style = "22 reverse";
          line-numbers = true;
          decoration = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
          };
        };
      };
      aliases = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
        ll =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white) <%an>%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
    };

  };

}
