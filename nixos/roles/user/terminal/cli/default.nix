{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./shell.nix
    ./helix.nix
    ./skim.nix
    ./starship.nix
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    rage
    signify
    #magic-wormhole
    bind
    bubblewrap
    cryfs
    curl
    fd
    xplr
    nnn
    git
    pijul
    htop
    kind
    nixos-shell
    lsof
    p7zip
    pango
    protonvpn-cli
    ripgrep
    tcpdump
    #sequoia
    tree
    wget
    yubikey-manager
  ];
}
