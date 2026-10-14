{
  flake.modules.homeManager.base =
    { lib, ... }:
    let
      entry = lib.types.either lib.types.str (lib.types.attrsOf lib.types.anything);
    in
    {
      # Paths (relative to $HOME) a program wants to survive reboots. Declared
      # next to the program itself; a host with impermanence maps them into
      # home.persistence (see users/<name>/impermanence.nix), elsewhere they are
      # a no-op.
      options.my.persist = {
        directories = lib.mkOption {
          type = lib.types.listOf entry;
          default = [ ];
          description = "Home directories to persist across reboots.";
          example = [ ".config/obsidian" ];
        };
        files = lib.mkOption {
          type = lib.types.listOf entry;
          default = [ ];
          description = "Home files to persist across reboots.";
          example = [ ".config/monitors.xml" ];
        };
      };
    };
}
