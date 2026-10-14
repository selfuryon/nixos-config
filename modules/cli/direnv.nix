{
  flake.modules.homeManager.cli = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    my.persist.directories = [ ".local/share/direnv" ];
  };
}
