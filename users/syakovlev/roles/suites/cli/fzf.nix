{ ... }:
let userName = "syakovlev";
in { home-manager.users.${userName}.programs.fzf = { enable = true; }; }
