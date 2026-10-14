{ inputs, ... }:
{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        inputs.sofka.packages.${pkgs.stdenv.hostPlatform.system}.default
        krew
        kubectl
        kubectx
      ];

      programs.k9s.enable = true;

      my.persist.directories = [
        ".config/helm"
        ".config/k9s"
        ".local/state/sofka"
      ];

      # sofka auto-detects dark/light; pin latte to match the rest of the desktop.
      xdg.configFile."sofka/config.toml".source = (pkgs.formats.toml { }).generate "sofka-config.toml" {
        skin.name = "catppuccin-latte";
      };
    };
}
