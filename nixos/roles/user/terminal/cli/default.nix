{
  pkgs,
  lib,
  config,
  inputs,
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

  # codex defaults to ~/.codex; point it at XDG_CONFIG_HOME instead.
  home.sessionVariables.CODEX_HOME = "${config.xdg.configHome}/codex";

  home.packages = with pkgs; [
    inputs.rip.packages.${pkgs.stdenv.hostPlatform.system}.default
    #magic-wormhole
    #sequoia
    claude-code
    codex
    gh
    bind
    insync
    bubblewrap
    # cryfs
    gocryptfs
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
    rclone
    pijul
    procs
    # protonvpn-cli
    rage
    devenv
    ripgrep
    signify
    tcpdump
    tldr
    # tailspin
    tree
    uv
    wget
    #yubikey-manager
    zk
    devenv
  ];
}
