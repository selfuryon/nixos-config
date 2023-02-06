_: {
  # Git configuration
  xdg.configFile = {
    "git/private.signers".text = ''
      selfuryon@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmB+ZN4UTQ+5IOvGrlBoHrCxfpQH7EWtLNR3qUrnQl5 selfuryon@github [private]
      selfuryon@pm.me ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmB+ZN4UTQ+5IOvGrlBoHrCxfpQH7EWtLNR3qUrnQl5 selfuryon@github [private]
    '';
    "git/p2p.signers".text = "sergey.y@p2p.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4yECpHN63wsadiWhM1zx600c3a/AboAzbipz8DaXoh sergey.y@github [p2p]";
  };
  programs.git = {
    enable = true;
    userName = "Sergey Yakovlev";
    userEmail = "selfuryon@pm.me";
    includes = [
      {
        condition = "gitdir:~/src/p2p/";
        contents = {
          user = {
            email = "sergey.y@p2p.org";
            signingKey = "~/.ssh/keys/p2p/github.pub";
          };
          gpg.ssh.allowedSignersFile = "~/.config/git/p2p.signers";
        };
      }
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.config/git/private.signers";
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
      ll = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white) <%an>%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };
  };
}
