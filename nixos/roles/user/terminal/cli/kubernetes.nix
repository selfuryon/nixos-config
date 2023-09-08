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
  xdg.configFile."k9s/skin.yml".source = "${inputs.catppuccin-k9s}/dist/latte.yml";
}
