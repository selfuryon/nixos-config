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
    dua
    duf
    entr
    procs
    curl
    fd
    git
    htop
    kind
    lsof
    nixos-shell
    p7zip
    pango
    pijul
    protonvpn-cli
    rage
    ranger
    ripgrep
    signify
    tcpdump
    tree
    wget
    xplr
    yubikey-manager
    zk
  ];
}
