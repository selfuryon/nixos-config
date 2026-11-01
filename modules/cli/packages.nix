{ inputs, ... }:
{
  flake.modules.homeManager.cli =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

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

      my.persist.directories = [
        ".config/claude"
        ".claude"
        ".local/share/claude"
        ".config/codex"
        ".config/gh"
        ".config/rclone"
        ".config/Insync"
      ];

      home.packages = with pkgs; [
        inputs.rip.packages.${pkgs.stdenv.hostPlatform.system}.default
        claude-code
        codex
        gh
        bind
        # The 3.9.11 .deb ships QtWebEngineProcess.debug, a split-debug ELF that
        # autoPatchelfHook fails to patch. stdenvNoCC is used only for the inner
        # insync-pkg derivation, so drop the .debug files there before fixup.
        (insync.override (prev: {
          stdenvNoCC = prev.stdenvNoCC // {
            mkDerivation =
              args:
              prev.stdenvNoCC.mkDerivation (
                args
                // {
                  postInstall = (args.postInstall or "") + ''
                    find $out -name '*.debug' -delete
                  '';
                }
              );
          };
        }))
        bubblewrap
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
        rage
        devenv
        ripgrep
        signify
        tcpdump
        tldr
        tree
        uv
        wget
        zk
      ];
    };
}
