{pkgs, ...}: {
  home.packages = with pkgs; [
    krew
    kubectl
    kubectx
  ];

  catppuccin.k9s.enable = true;
  programs.k9s.enable = true;
}
