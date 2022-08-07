{ lib, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
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
          success_symbol = "[ I ](fg:black bg:green)";
          error_symbol = "[ I ](fg:black bg:red)";
          vicmd_symbol = "[ N ](fg:black bg:#54aeff)";
          vimcmd_replace_one_symbol =
            "[ r ](fg:black bg:red)";
          vimcmd_replace_symbol =
            "[ R ](fg:black bg:red)";
          vimcmd_visual_symbol =
            "[ V ](fg:black bg:yellow)";
        };
      };
    };
  };
}
