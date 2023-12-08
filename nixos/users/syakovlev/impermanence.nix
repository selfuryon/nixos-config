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
        ".config/cryptostore"
        ".config/dconf"
        ".config/discord"
        ".config/helm"
        ".config/keepassxc"
        ".local/share/TelegramDesktop"
        ".local/share/data/Mega Limited/MEGAsync"
        ".local/share/direnv"
        ".local/share/keyrings"
        ".local/share/gnupg"
        ".ssh"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "data"
        "mega"
        "nixos-config"
        "src"
      ];
      allowOther = true;
    };
  };
}
