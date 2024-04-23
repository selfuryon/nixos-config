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
        ".config/Insomnia"
        ".config/Logseq"
        ".config/Slack"
        ".config/BraveSoftware"
        ".config/cryptostore"
        ".config/dconf"
        ".config/discord"
        ".config/helm"
        ".config/keepassxc"
        ".config/frame"
        ".config/k9s"
        ".config/Ledger Live"
        ".local/share/TelegramDesktop"
        ".local/share/data/Mega Limited/MEGAsync"
        ".local/share/direnv"
        ".local/share/keyrings"
        ".local/share/gnupg"
        ".ssh"
        ".ipfs"
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
