{ config, lib, pkgs, ... }: {
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
    ./tmux.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bind
    bubblewrap
    crosvm
    cryfs
    curl
    fd
    git
    haskellPackages.ghcup
    htop
    kind
    kubectl
    lsof
    neovim-nightly
    p7zip
    pango
    pijul
    polkit_gnome
    protonvpn-cli
    ripgrep
    rustup
    sequoia
    tmux
    tree
    wget
    yubikey-manager
  ];
}
