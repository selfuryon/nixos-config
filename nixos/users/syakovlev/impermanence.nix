{inputs, ...}: let
  userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    imports = [
      inputs.impermanence.nixosModules.home-manager.impermanence
    ];
    home.persistence."/state/home/syakovlev" = {
      directories = [
        # global
        ".config/BraveSoftware"
        ".config/google-chrome"
        ".config/Insomnia"
        ".config/Ledger Live"
        ".config/Logseq"
        ".config/Slack"
        ".config/cryptostore"
        ".config/dconf"
        ".config/discord"
        ".config/frame"
        ".config/rclone"
        ".config/helm"
        ".config/k9s"
        ".config/keepassxc"
        ".ipfs"
        ".ollama"
        ".local/share/TelegramDesktop"
        ".local/share/atuin"
        ".local/share/data/Mega Limited/MEGAsync"
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
        "mega"
        "src"
      ];
      allowOther = true;
    };
  };
}
