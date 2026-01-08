let
  userName = "syakovlev";
in
{
  home-manager.users.${userName} = {
    # imports = [
    #   inputs.impermanence.nixosModules.home-manager.impermanence
    # ];
    home.persistence."/state" = {
      directories = [
        # global
        ".cargo"
        ".config/BraveSoftware"
        ".config/google-chrome"
        ".config/Insomnia"
        ".config/Ledger Live"
        ".config/Joplin"
        ".config/joplin-desktop"
        ".config/Slack"
        ".config/cryptostore"
        ".config/dconf"
        # ".config/discord"
        ".config/vesktop"
        ".config/Vencord"
        ".config/frame"
        ".config/rclone"
        ".config/helm"
        ".config/k9s"
        ".config/keepassxc"
        ".config/Insync"
        ".ipfs"
        ".config/claude"
        ".claude"
        ".local/share/claude"
        ".ollama"
        ".local/share/TelegramDesktop"
        ".local/share/atuin"
        ".local/share/direnv"
        ".local/share/gnupg"
        ".local/share/keyrings"
        ".local/share/zoxide"
        ".ssh"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "data"
        "cloud"
        "src"
      ];
    };
  };
}
