{
  # Git configuration
  xdg.configFile = {
    "git/personal.signers".text = ''
      selfuryon@pm.me ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmB+ZN4UTQ+5IOvGrlBoHrCxfpQH7EWtLNR3qUrnQl5 selfuryon@github [private]
      sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOacgO1zUpZZQjFdgVjuJgZsTDATpAcgv1R2499P++FrAAAABHNzaDo= sergey.y@yubikey-blue [private] 
      sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIC3+NdnJ1kFk8wxyJ/mI5giVwSbnLmzhcyO+/AdhcEcMAAAABHNzaDo= sergey.y@yubikey-grey [private]
    '';
    "git/p2p.signers".text =
      "sergey.y@p2p.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4yECpHN63wsadiWhM1zx600c3a/AboAzbipz8DaXoh sergey.y@github [p2p]";
  };
  programs.git = {
    enable = true;
    userName = "Sergey Yakovlev";
    userEmail = "selfuryon@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.config/git/personal.signers";
    };
    signing = {
      signByDefault = true;
      key = "~/.ssh/keys/personal/github.pub";
    };
    delta = {
      enable = false;
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
