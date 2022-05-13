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
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bind
    bubblewrap
    cryfs
    curl
    fd
    git
    htop
    kind
    lsof
    neovim-nightly
    p7zip
    pango
    polkit_gnome
    protonvpn-cli
    ripgrep
    sequoia
    tmux
    tree
    wget
    yubikey-manager
  ];
}
