{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./direnv.nix
    ./fish.nix
    ./nushell.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./kubernetes.nix
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
    claude-code
    bind
    insync
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
    # logseq
    pango
    rclone
    pijul
    procs
    protonvpn-cli
    rage
    devenv
    ripgrep
    signify
    tcpdump
    tldr
    # tailspin
    tree
    wget
    #yubikey-manager
    zk
    devenv
  ];
}
