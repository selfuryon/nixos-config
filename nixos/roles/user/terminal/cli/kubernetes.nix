{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krew
    kubectl
    kubectx
  ];

  programs.k9s.enable = true;
}
