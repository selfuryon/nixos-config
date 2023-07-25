{
  programs = {
    zoxide.enable = true;
    atuin = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        style = "compact";
        search_mode = "skim";
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
        if status is-interactive; and set -q SSH_TTY;
          set ZELLIJ_AUTO_ATTACH true
          set ZELLIJ_AUTO_EXIT true
          eval (zellij setup --generate-auto-start fish | string collect)
        end
      '';
    };
  };
}
