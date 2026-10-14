{ inputs, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;
      };
    };

  flake.modules.homeManager.desktop =
    { pkgs, lib, ... }:
    let
      catppuccinRed = "#d20f39";
      catppuccinMaroon = "#e64553";
    in
    {
      imports = [ inputs.niri.homeModules.niri ];
      programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;

      home.packages = with pkgs; [
        wayland
        xwayland-satellite
        nautilus # for GNOME Portal File Picker
        wdisplays
      ];
      xdg.portal = {
        enable = true;
        configPackages = [ pkgs.xdg-desktop-portal-gnome ];
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      };

      # DankMaterialShell adds its own binds on top of these (launcher, lock,
      # volume/brightness OSD, ...), see dms.nix: programs.dank-material-shell.niri.
      programs.niri.settings = {
        environment = {
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";
          QT_QPA_PLATFORM = "wayland";
          QT_QPA_PLATFORMTHEME = "qt5ct";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

          ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          SDL_VIDEODRIVER = "wayland";
          GDK_BACKEND = "wayland,x11";
          GTK_USE_PORTAL = "1";

          NIXOS_OZONE_WL = "1";
        };

        input = {
          keyboard.xkb = {
            layout = "us,ru";
            variant = ",chm";
            options = "grp:shift_caps_switch";
          };
          touchpad = {
            tap = true;
            natural-scroll = true;
            accel-speed = 1.0;
            accel-profile = "flat";
            scroll-method = "two-finger";
          };
        };

        outputs."eDP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 120.030;
          };
          scale = 1;
          position = {
            x = 0;
            y = 0;
          };
        };

        layout = {
          gaps = 24;
          center-focused-column = "never";
          preset-column-widths = [
            { proportion = 0.3; }
            { proportion = 0.5; }
            { proportion = 0.7; }
          ];
          default-column-width.proportion = 0.7;
          focus-ring = {
            width = 6;
            active.gradient = {
              from = "#1e66f5";
              to = "#7287fd";
              angle = 45;
            };
            inactive.gradient = {
              from = "#acb0be";
              to = "#ccd0da";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
          tab-indicator = {
            width = 8;
            gap = 8;
            length.total-proportion = 1.0;
            position = "left";
            active.color = "#8839ef";
            inactive.color = "#ccd0da";
          };
          border.enable = false;
        };

        prefer-no-csd = true;

        # Sorted by key; the prefix keeps the declaration order.
        workspaces = {
          "1-term".name = "term";
          "2-code".name = "code";
          "3-browser".name = "browser";
          "4-mail".name = "mail";
          "5-im".name = "im";
          "6-secret".name = "secret";
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        screenshot-path = "~/Pictures/Screenshots/screenshot-%Y-%m-%dT%H-%M-%S.png";
        hotkey-overlay.skip-at-startup = true;
        animations.slowdown = 2.0;

        window-rules = [
          {
            geometry-corner-radius = {
              top-left = 20.0;
              top-right = 20.0;
              bottom-right = 20.0;
              bottom-left = 20.0;
            };
            clip-to-geometry = true;
          }
          # Work around WezTerm's initial configure bug by setting an empty
          # default-column-width.
          {
            matches = [ { app-id = ''^org\.wezfurlong\.wezterm$''; } ];
            default-column-width = { };
          }
          # Open the Firefox Picture-in-Picture window at the bottom-left
          # corner of the screen with a small gap.
          {
            matches = [
              {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
            default-floating-position = {
              x = 32;
              y = 32;
              relative-to = "bottom-left";
            };
          }
          # Block KeePassXC from screencasts and screenshots.
          {
            matches = [ { app-id = ''^org\.keepassxc\.KeePassXC$''; } ];
            block-out-from = "screen-capture";
          }
          # Indicate screencasted windows with red colors.
          {
            matches = [ { is-window-cast-target = true; } ];
            focus-ring = {
              active.color = catppuccinRed;
              inactive.color = catppuccinMaroon;
            };
            border.inactive.color = catppuccinMaroon;
            shadow.color = "${catppuccinMaroon}70";
            tab-indicator = {
              active.color = catppuccinRed;
              inactive.color = catppuccinMaroon;
            };
          }
        ];

        layer-rules = [
          {
            matches = [ { namespace = "^launcher$"; } ];
            shadow.enable = true;
          }
          {
            matches = [ { namespace = "^dms:workspace-overview$"; } ];
            place-within-backdrop = true;
          }
          {
            matches = [ { namespace = "^dms:bar$"; } ];
            place-within-backdrop = false;
          }
          {
            matches = [ { namespace = "^dms:clipboard$"; } ];
            block-out-from = "screencast";
          }
          {
            matches = [ { namespace = "^dms:notification-popup$"; } ];
            block-out-from = "screencast";
          }
        ];

        debug.honor-xdg-activation-with-invalid-serial = [ ];

        binds =
          let
            bind = action: { inherit action; };
            workspaceBinds = lib.listToAttrs (
              lib.concatMap (
                i:
                let
                  n = toString i;
                in
                [
                  (lib.nameValuePair "Mod+${n}" (bind {
                    focus-workspace = i;
                  }))
                  (lib.nameValuePair "Mod+Ctrl+${n}" (bind {
                    move-column-to-workspace = i;
                  }))
                ]
              ) (lib.range 1 9)
            );
            wheel = action: {
              inherit action;
              cooldown-ms = 150;
            };
          in
          workspaceBinds
          // {
            "Mod+T" = bind { spawn = "kitty"; };
            "Mod+Return" = bind { spawn = "kitty"; };
            "Mod+D" = bind { spawn = "fuzzel"; };

            "Mod+Q" = bind { close-window = [ ]; };

            "Mod+Left" = bind { focus-column-left = [ ]; };
            "Mod+Down" = bind { focus-window-down = [ ]; };
            "Mod+Up" = bind { focus-window-up = [ ]; };
            "Mod+Right" = bind { focus-column-right = [ ]; };
            "Mod+H" = bind { focus-column-left = [ ]; };
            "Mod+J" = bind { focus-window-down = [ ]; };
            "Mod+K" = bind { focus-window-up = [ ]; };
            "Mod+L" = bind { focus-column-right = [ ]; };

            "Mod+Ctrl+Left" = bind { move-column-left = [ ]; };
            "Mod+Ctrl+Down" = bind { move-window-down = [ ]; };
            "Mod+Ctrl+Up" = bind { move-window-up = [ ]; };
            "Mod+Ctrl+Right" = bind { move-column-right = [ ]; };
            "Mod+Ctrl+H" = bind { move-column-left = [ ]; };
            "Mod+Ctrl+J" = bind { move-window-down = [ ]; };
            "Mod+Ctrl+K" = bind { move-window-up = [ ]; };
            "Mod+Ctrl+L" = bind { move-column-right = [ ]; };

            "Mod+Home" = bind { focus-column-first = [ ]; };
            "Mod+End" = bind { focus-column-last = [ ]; };
            "Mod+Ctrl+Home" = bind { move-column-to-first = [ ]; };
            "Mod+Ctrl+End" = bind { move-column-to-last = [ ]; };

            "Mod+Shift+Left" = bind { focus-monitor-left = [ ]; };
            "Mod+Shift+Down" = bind { focus-monitor-down = [ ]; };
            "Mod+Shift+Up" = bind { focus-monitor-up = [ ]; };
            "Mod+Shift+Right" = bind { focus-monitor-right = [ ]; };
            "Mod+Shift+H" = bind { focus-monitor-left = [ ]; };
            "Mod+Shift+J" = bind { focus-monitor-down = [ ]; };
            "Mod+Shift+K" = bind { focus-monitor-up = [ ]; };
            "Mod+Shift+L" = bind { focus-monitor-right = [ ]; };

            "Mod+Shift+Ctrl+Left" = bind { move-column-to-monitor-left = [ ]; };
            "Mod+Shift+Ctrl+Down" = bind { move-column-to-monitor-down = [ ]; };
            "Mod+Shift+Ctrl+Up" = bind { move-column-to-monitor-up = [ ]; };
            "Mod+Shift+Ctrl+Right" = bind { move-column-to-monitor-right = [ ]; };
            "Mod+Shift+Ctrl+H" = bind { move-column-to-monitor-left = [ ]; };
            "Mod+Shift+Ctrl+J" = bind { move-column-to-monitor-down = [ ]; };
            "Mod+Shift+Ctrl+K" = bind { move-column-to-monitor-up = [ ]; };
            "Mod+Shift+Ctrl+L" = bind { move-column-to-monitor-right = [ ]; };

            "Mod+Page_Down" = bind { focus-workspace-down = [ ]; };
            "Mod+Page_Up" = bind { focus-workspace-up = [ ]; };
            "Mod+U" = bind { focus-workspace-down = [ ]; };
            "Mod+I" = bind { focus-workspace-up = [ ]; };
            "Mod+Ctrl+Page_Down" = bind { move-column-to-workspace-down = [ ]; };
            "Mod+Ctrl+Page_Up" = bind { move-column-to-workspace-up = [ ]; };
            "Mod+Ctrl+U" = bind { move-column-to-workspace-down = [ ]; };
            "Mod+Ctrl+I" = bind { move-column-to-workspace-up = [ ]; };

            "Mod+Shift+Page_Down" = bind { move-workspace-down = [ ]; };
            "Mod+Shift+Page_Up" = bind { move-workspace-up = [ ]; };
            "Mod+Shift+U" = bind { move-workspace-down = [ ]; };
            "Mod+Shift+I" = bind { move-workspace-up = [ ]; };

            "Mod+WheelScrollDown" = wheel { focus-workspace-down = [ ]; };
            "Mod+WheelScrollUp" = wheel { focus-workspace-up = [ ]; };
            "Mod+Ctrl+WheelScrollDown" = wheel { move-column-to-workspace-down = [ ]; };
            "Mod+Ctrl+WheelScrollUp" = wheel { move-column-to-workspace-up = [ ]; };

            "Mod+WheelScrollRight" = bind { focus-column-right = [ ]; };
            "Mod+WheelScrollLeft" = bind { focus-column-left = [ ]; };
            "Mod+Ctrl+WheelScrollRight" = bind { move-column-right = [ ]; };
            "Mod+Ctrl+WheelScrollLeft" = bind { move-column-left = [ ]; };

            # Shift+wheel usually scrolls horizontally in applications.
            "Mod+Shift+WheelScrollDown" = bind { focus-column-right = [ ]; };
            "Mod+Shift+WheelScrollUp" = bind { focus-column-left = [ ]; };
            "Mod+Ctrl+Shift+WheelScrollDown" = bind { move-column-right = [ ]; };
            "Mod+Ctrl+Shift+WheelScrollUp" = bind { move-column-left = [ ]; };

            # DMS binds Mod+Comma (settings) and Mod+V (clipboard); keep the
            # niri column/floating actions on these keys.
            "Mod+Comma" = lib.mkForce (bind {
              consume-window-into-column = [ ];
            });
            "Mod+Period" = bind { expel-window-from-column = [ ]; };
            "Mod+BracketLeft" = bind { consume-or-expel-window-left = [ ]; };
            "Mod+BracketRight" = bind { consume-or-expel-window-right = [ ]; };

            "Mod+R" = bind { switch-preset-column-width = [ ]; };
            "Mod+Shift+R" = bind { switch-preset-window-height = [ ]; };
            "Mod+Ctrl+R" = bind { reset-window-height = [ ]; };
            "Mod+F" = bind { maximize-column = [ ]; };
            "Mod+Shift+F" = bind { fullscreen-window = [ ]; };
            "Mod+C" = bind { center-column = [ ]; };

            "Mod+Minus" = bind { set-column-width = "-10%"; };
            "Mod+Equal" = bind { set-column-width = "+10%"; };
            "Mod+Shift+Minus" = bind { set-window-height = "-10%"; };
            "Mod+Shift+Equal" = bind { set-window-height = "+10%"; };

            "Mod+V" = lib.mkForce (bind {
              toggle-window-floating = [ ];
            });
            "Mod+Shift+V" = bind { switch-focus-between-floating-and-tiling = [ ]; };
            "Mod+W" = bind { toggle-column-tabbed-display = [ ]; };

            "Print" = bind { screenshot = [ ]; };
            "Ctrl+Print" = bind { screenshot-screen = [ ]; };
            "Alt+Print" = bind { screenshot-window = [ ]; };

            # quit shows a confirmation dialog.
            "Mod+Shift+E" = bind { quit = [ ]; };
            "Ctrl+Alt+Delete" = bind { quit = [ ]; };

            # Any input turns the monitors back on.
            "Mod+Shift+P" = bind { power-off-monitors = [ ]; };
          };
      };
    };
}
