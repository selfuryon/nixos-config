{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    loginExtra = ''
    if [[ $TTY == "/dev/tty1" ]]; then
      exec sway
    fi
    '';
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    history.extended = true;
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
  };
}
