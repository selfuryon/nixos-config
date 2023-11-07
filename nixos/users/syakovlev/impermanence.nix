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
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".ssh"
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
        "src"
        "mega"
        "nixos-config"
        "data"
      ];
      allowOther = true;
    };
  };
}
