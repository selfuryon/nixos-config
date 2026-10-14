let
  userName = "syakovlev";
in
{
  home-manager.users.${userName} =
    { config, ... }:
    {
      # Programs declare their own paths via my.persist next to their config;
      # only data and tools without a module of their own are listed here.
      my.persist.directories = [
        ".cargo"
        ".config/cryptostore"
        ".config/nix"
        ".ipfs"
        ".local/share/Anki2"
        ".local/share/keyrings"
        ".ollama"
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

      home.persistence."/state" = {
        inherit (config.my.persist) directories files;
      };
    };
}
