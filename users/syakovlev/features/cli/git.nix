{ ... }:
let userName = "syakovlev";
in {
  # Git configuration
  home-manager.users.${userName}.programs.git = {
    enable = true;
    userName = "Sergey Yakovlev";
    userEmail = "selfuryon@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    signing = {
      signByDefault = true;
      key = "0x9933BC25075D15A2";
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
}
