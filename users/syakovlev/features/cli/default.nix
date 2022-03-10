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
    htop
    ripgrep
    lsof
    fd
    tree
    git
    tmux
    cryfs
    kind
    kubectl
    protonvpn-cli
    p7zip
    crosvm
    haskellPackages.ghcup
    rustup
    yubikey-manager
    neovim-nightly
    curl
    wget
    pango
    polkit_gnome
    bind
  ];
}
