{ config, pkgs, ... }: {
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    jetbrains-mono
    source-code-pro
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })
  ];
}
