{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    k9s
    krew
    kubectl
    kubectx
  ];
  xdg.configFile."k9s/skins/catppuccin-latte.yaml".source = "${inputs.catppuccin-k9s}/dist/catppuccin-latte.yaml";
}
