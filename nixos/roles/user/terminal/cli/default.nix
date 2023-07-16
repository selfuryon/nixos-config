{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./lazygit.nix
    ./shell.nix
    ./skim.nix
    ./starship.nix
    ./zellij.nix
  ];

  xdg.enable = true;
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
    ranger
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
    zk
  ];
}
