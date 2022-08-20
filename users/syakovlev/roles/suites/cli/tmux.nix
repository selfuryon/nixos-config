{ pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName}.programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 50000;
    keyMode = "vi";
    terminal = "xterm-256color";
    newSession = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set -g @tilish-default 'main-vertical'
          set -g @tilish-navigator 'on'
        '';
      }
      { plugin = tmuxPlugins.vim-tmux-navigator; }
    ];
    extraConfig = ''
      set-option -g mouse on
      set-option -g status "on"

      # COLORSCHEME: PaperColor
      BG1="#005f87"
      BG2="#e4e4e4"
      BG3="#0087af"
      FG1="#444444"

      # default statusbar colors
      set-option -g status-bg $BG1 #bg1
      set-option -g status-fg $FG1 #fg1


      # default window title colors
      set-window-option -g window-status-style bg=$BG1,fg=$BG3
      set-window-option -g window-status-activity-style bg=$BG2,fg=colour248 #fg3

      # active window title colors
      set-window-option -g window-status-current-style bg=$BG2,fg=$BG1

      # pane border
      set-option -g pane-active-border-style fg=$BG3
      set-option -g pane-border-style fg=$BG3

      # message infos
      set-option -g message-style bg=$BG1,fg=$BG2

      # commands
      set-option -g message-command-style bg=$BG1,fg=$FG1

      # pane number display
      set-option -g display-panes-active-colour colour250 #fg2
      set-option -g display-panes-colour colour237 #bg1

      # clock
      set-window-option -g clock-mode-colour colour24 #blue

      # bell
      set-window-option -g window-status-bell-style fg=colour229,bg=colour88 #bg, red

      set-option -g status-justify "left"
      set-option -g status-left-length "80"
      set-option -g status-right-length "80"
      set-window-option -g window-status-separator ""

      set-option -g status-left "#[fg=$FG1, bg=$BG2] #S #[fg=$BG2, bg=$BG1, nobold, noitalics, nounderscore]"
      set-option -g status-right "#[fg=$BG3, bg=$BG1, nobold, nounderscore, noitalics]#[fg=$BG2,bg=$BG3] %Y-%m-%d  %H:%M #[fg=$BG2, bg=$BG3, nobold, noitalics, nounderscore]#[fg=$FG1, bg=$BG2] #h "

      set-window-option -g window-status-current-format "#[fg=$BG3, bg=$BG1, :nobold, noitalics, nounderscore]#[fg=$BG1, bg=$BG2] #I #[fg=$BG1, bg=$BG2, bold] #W #[fg=$BG2, bg=$BG1, nobold, noitalics, nounderscore]"
      set-window-option -g window-status-format "#[fg=$BG1,bg=$BG3,noitalics]#[fg=$BG2,bg=$BG3] #I #[fg=$BG2, bg=$BG3] #W #[fg=$BG3, bg=$BG1, noitalics]"
    '';
  };
}
