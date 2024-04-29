{
  lib,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
    catppuccin.enable = true;
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

      character = with config.scheme.withHashtag; {
        success_symbol = "[ I ](fg:#ffffff bg:${base0B})";
        error_symbol = "[ I ](fg:#ffffff bg:${base08})";
        vicmd_symbol = "[ N ](fg:#ffffff bg:${base0D})";
        vimcmd_replace_one_symbol = "[ r ](fg:#ffffff bg:${base09})";
        vimcmd_replace_symbol = "[ R ](fg:#ffffff bg:${base09})";
        vimcmd_visual_symbol = "[ V ](fg:#ffffff bg:${base0F})";
      };
    };
  };
}
