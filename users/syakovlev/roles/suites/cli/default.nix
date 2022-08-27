{ pkgs, config, ... }:
let
  userName = "syakovlev";
in {
  imports = [
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./shell.nix
    ./skim.nix
    ./starship.nix
    ./nvim.nix
    #./tmux.nix
    ./zellij.nix
  ];

  home-manager.users.${userName}.home.packages = with pkgs; [
    rage
    signify
    #magic-wormhole
    bind
    bubblewrap
    cryfs
    curl
    fd
    git
    pijul
    htop
    kind
    lsof
    p7zip
    pango
    polkit_gnome
    protonvpn-cli
    ripgrep
    sequoia
    tree
    wget
    yubikey-manager
  ];
}
