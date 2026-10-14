{
  flake.modules.homeManager.desktop =
    { pkgs, config, ... }:
    {

      home.activation."mimeapps-remove" = {
        before = [ "checkLinkTargets" ];
        after = [ ];
        data = "rm -f ${config.xdg.configHome}/mimeapps.list";
      };

      xdg = {
        mimeApps = {
          enable = true;
          defaultApplications = {
            "text/html" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
            "image/*" = [ "firefox.desktop" ];

            "application/zip" = [ "org.gnome.FileRoller.desktop" ];
            "application/rar" = [ "org.gnome.FileRoller.desktop" ];
            "application/7z" = [ "org.gnome.FileRoller.desktop" ];
            "application/*tar" = [ "org.gnome.FileRoller.desktop" ];

            "inode/directory" = [ "thunar.desktop" ];
            "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
            "x-scheme-handler/matrix" = [ "element.desktop" ];
            "video/*" = [ "vlc.desktop" ];
            "application/pdf" = [ "org.kde.okular" ];

            "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
            "application/msword" = [ "writer.desktop" ];
            "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
            "text/csv" = [ "calc.desktop" ];
          };
        };
      };

      # State of the GUI apps below.
      my.persist.directories = [
        ".config/BraveSoftware"
        ".config/google-chrome"
        ".config/bruno"
        ".config/Ledger Live"
        ".config/obsidian"
        ".config/Slack"
        ".config/dconf"
        ".config/vesktop"
        ".config/Vencord"
        ".config/frame"
        ".config/keepassxc"
        ".local/share/TelegramDesktop"
      ];

      home.packages = with pkgs; [
        adwaita-qt
        # anki  # disabled: build broken upstream, https://github.com/NixOS/nixpkgs/issues/548443
        google-chrome
        brave
        kdePackages.kwallet
        capitaine-cursors
        crosvm
        dconf
        vesktop
        drawio
        framesh
        file-roller
        grim
        gsettings-desktop-schemas
        imv
        hoppscotch
        keepassxc
        libreoffice
        onlyoffice-desktopeditors
        ledger-live-desktop
        mpv
        networkmanagerapplet
        kdePackages.okular
        pavucontrol
        qbittorrent
        slack
        slurp
        swappy
        telegram-desktop
        virt-manager
        virt-viewer
        vlc
        wf-recorder
        wireshark
        xdg-utils
        obsidian
        thunar
        kdePackages.dolphin
        thunar-media-tags-plugin
        xrdb
        xournalpp
        xwayland
        bruno
        wayland
        pciutils
        swaybg
        glib # gsettings
        qt6.qt5compat
        qt6.qtwayland
        wl-clipboard
        cliphist
      ];
    };
}
