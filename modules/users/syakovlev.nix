{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
  credentials = import ./_credentials.nix;
  userName = "syakovlev";
in
{
  flake.modules.nixos.syakovlev =
    { pkgs, ... }:
    {
      users.users.${userName} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "sudo"
          "doas"
          "video"
          "audio"
          "libvirtd"
          "usb"
          "ssh"
          "wireshark"
        ];
        shell = pkgs.nushell;
        inherit (credentials) hashedPassword;
        openssh.authorizedKeys.keys = credentials.authorizedKeys;
      };
      programs.fish.enable = true;

      home-manager.users.${userName} = {
        imports = [ homeManager.cli ];
        home.stateVersion = "26.11";
        services.podman = {
          enable = true;
          settings.storage.storage = {
            graphroot = "/containers/${userName}";
          };
        };

        # Data and tools without a module of their own; programs declare
        # their paths next to their config.
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
      };
    };
}
