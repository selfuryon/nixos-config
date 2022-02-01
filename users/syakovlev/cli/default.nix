{ config, lib, pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./mpd.nix
    ./shell.nix
    ./skim.nix
    ./starship.nix
    ./nvim.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ 
    htop 
    ripgrep
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
    neovim
    curl
    wget
    pango
    polkit_gnome
    bind
  ]; 
}
