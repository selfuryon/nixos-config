{ pkgs, ... }: {
  programs.fzf = {
    enable = false;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions =  [ "--preview 'head {}'" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
