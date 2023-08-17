{
  pkgs,
  lib,
  config,
  ...
}: {
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

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = lib.mkDefault true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
  };

  home.packages = with pkgs; [
    #magic-wormhole
    #sequoia
    bind
    bubblewrap
    cryfs
    curl
    dua
    duf
    entr
    fd
    git
    htop
    kind
    lsof
    nixos-shell
    p7zip
    pango
    pijul
    procs
    protonvpn-cli
    rage
    xplr
    ripgrep
    signify
    tcpdump
    tldr
    tree
    wget
    xplr
    #yubikey-manager
    zk
  ];
}
