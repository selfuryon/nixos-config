{ pkgs, ... }: {
  fonts.fonts = with pkgs; [
    noto-fonts
    jetbrains-mono
    source-code-pro
    fira-code
    fira-code-symbols
    paratype-pt-sans
    paratype-pt-mono
    paratype-pt-serif
    font-awesome
    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })
  ];
}
