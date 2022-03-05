{ pkgs, lib, ... }: {
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
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vicmd_symbol = "[V](bold green)";
      };
    };
  };
}
