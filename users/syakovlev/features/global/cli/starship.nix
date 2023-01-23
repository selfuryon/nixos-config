{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$kubernetes"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$package"
        "$golang"
        "$helm"
        "$python"
        "$rust"
        "$terraform"
        "$vagrant"
        "$nix_shell"
        "$aws"
        "$gcloud"
        "$cmd_duration"
        "$time"
        "$line_break"
        "$character"
      ];

      kubernetes.disabled = false;
      cmd_duration.min_time = 500;

      time = {
        disabled = false;
        time_format = "%T";
      };

      character = {
        success_symbol = "[ I ](fg:#ffffff bg:#2da44e)";
        error_symbol = "[ I ](fg:#ffffff bg:#cf222e)";
        vicmd_symbol = "[ N ](fg:#ffffff bg:#0969da)";
        vimcmd_replace_one_symbol = "[ r ](fg:#ffffff bg:#cf222e)";
        vimcmd_replace_symbol = "[ R ](fg:#ffffff bg:#cf222e)";
        vimcmd_visual_symbol = "[ V ](fg:#ffffff bg:#bf8700)";
      };
    };
  };
}
