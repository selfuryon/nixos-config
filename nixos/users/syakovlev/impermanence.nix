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
        ".config/cryptostore"
        # personal
        "src"
        "mega"
        "nixos-config"
        "data"
      ];
      allowOther = true;
    };
  };
}
