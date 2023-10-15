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
        ".local/share/keyrings"
        ".local/share/direnv"
        # personal
        ".local/share/TelegramDesktop"
        ".local/share/data/Mega Limited/MEGAsync"
        ".config/keepassxc"
        ".config/dconf"
        ".config/cryptostore"
        ".config/Slack"
        ".config/discord"
        "src"
        "mega"
        "nixos-config"
        "data"
      ];
      allowOther = true;
    };
  };
}
