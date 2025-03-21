{pkgs, ...}: let
  # hyprland = "${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/Hyprland";
  hyprland = "${pkgs.hyprland}/bin/Hyprland";
in {
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./swaync.nix
    ./firefox.nix
    ./thunderbird.nix
    ./font.nix
    ./foot.nix
    ./gtk.nix
    ./ghostty.nix
    ./kitty.nix
    ./mpd.nix
    ./playerctl.nix
    ./qt.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    #./swayidle.nix
    #./swaylock.nix
    ./waybar.nix
    ./wlsunset.nix
    #./wofi.nix
    ./fuzzel.nix
    ./wezterm.nix
  ];

  programs.fish.loginShellInit = ''
    if test (tty) = /dev/tty1
      systemd-cat -t hyprland ${hyprland}
    end
  '';
  programs.nushell.loginFile.text = ''
    if (tty) == "/dev/tty3" {
      systemd-cat -t hyprland ${hyprland}
    }
  '';

  home.activation."mimeapps-remove" = {
    before = ["checkLinkTargets"];
    after = [];
    data = "rm -f /home/syakovlev/.config/mimeapps.list";
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["firefox.desktop" "firefox-work.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop" "firefox-work.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop" "firefox-work.desktop"];
        "image/*" = ["firefox.desktop" "firefox-work.desktop"];

        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/rar" = ["org.gnome.FileRoller.desktop"];
        "application/7z" = ["org.gnome.FileRoller.desktop"];
        "application/*tar" = ["org.gnome.FileRoller.desktop"];

        "inode/directory" = ["thunar.desktop"];
        "x-scheme-handler/mailto" = ["thunderbird.desktop"];
        "x-scheme-handler/matrix" = ["element.desktop"];
        "video/*" = ["vlc.desktop"];
        "application/pdf" = ["org.kde.okular"];

        "application/vnd.oasis.opendocument.text" = ["writer.desktop"];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"];
        "application/msword" = ["writer.desktop"];
        "application/vnd.oasis.opendocument.spreadsheet" = ["calc.desktop"];
        "text/csv" = ["calc.desktop"];
      };
    };

    desktopEntries = {
      megasync = {
        name = "Megasync (Wayland)";
        genericName = "File Synchronizer";
        exec = "megasync -platform xcb";
        icon = "mega";
        terminal = false;
        categories = ["Network" "System"];
      };
    };
  };

  home.packages = with pkgs; [
    adwaita-qt
    libsForQt5.lightly
    google-chrome
    brave
    capitaine-cursors
    crosvm
    dconf
    discord
    drawio
    framesh
    file-roller
    grim
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    joplin-desktop
    imv
    hoppscotch
    keepassxc
    libreoffice
    onlyoffice-bin
    ledger-live-desktop
    megasync
    mpv
    networkmanagerapplet
    kdePackages.okular
    pavucontrol
    qbittorrent
    #librewolf
    #qutebrowser
    skypeforlinux
    slack
    slurp
    swappy
    tdesktop
    tigervnc
    virt-manager
    virt-viewer
    vlc
    wf-recorder
    wireshark
    xdg-utils
    pcmanfm-qt
    xfce.thunar
    xfce.thunar-media-tags-plugin
    xorg.xrdb
    xournalpp
    xwayland
    insomnia
    #zotero
  ];
}
