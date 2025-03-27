{pkgs, ...}: {
  imports = [../common];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; #uwsm enabled
    systemd.variables = ["--all"];
    settings = {
      monitor = ",preferred,auto,1";
      workspace = "eDP-1,11";
      input = {
        kb_layout = "us,ru";
        kb_variant = ",chm";
        kb_options = "grp:shift_caps_switch";
        follow_mouse = 0;
        sensitivity = "0.6";
        touchpad = {
          natural_scroll = true;
          scroll_factor = "1.2";
        };
      };
      master = {
        mfact = "0.7";
      };
      general = {
        layout = "scroller";

        gaps_in = 16;
        gaps_out = 20;
        border_size = 6;

        "col.active_border" = "$sky $lavender 0deg";
        "col.inactive_border" = "$surface1";
      };
      decoration = {
        active_opacity = 1;
        dim_inactive = true;
        dim_strength = ".105";
        fullscreen_opacity = "1.0";
        rounding = 12;

        inactive_opacity = "0.80";
        shadow = {
          enabled = true;
          offset = "3 3";
          range = 12;
        };
        blur = {
          enabled = true;
          ignore_opacity = true;
          new_optimizations = true;
          passes = 3;
          size = 6;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinout,0.45, 0, 0.55, 1"
        ];
        animation = [
          "windowsIn,1,3,easeout,slide"
          "windowsOut,1,3,easein,slide"
          "windowsMove,1,3,easeout"
          "fadeIn,1,3,easeout"
          "fadeOut,1,3,easein"
          "fadeSwitch,1,3,easeout"
          "fadeShadow,1,3,easeout"
          "fadeDim,1,3,easeout"
          "border,1,3,easeout"
          "workspaces,1,2,easeout,slide"
        ];
      };
      # Rules
      windowrule = [
        "float,^(pavucontrol)$"
        "float,^(nm-connection-editor)$"
        "float,^(polkit-gnome-authentication-agent-1)$"

        # common modals
        "float,title:^(Open)$"
        "float,title:^(Choose Files)$"
        "float,title:^(Save As)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
      ];

      # Others
      windowrulev2 = [
        "float,class:^(MEGAsync)$"
        "float,size 0 0, move 10 10,title:(Sharing Indicator)"
      ];
      exec-once = [
        "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
      ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        #"QT_STYLE_OVERRIDE,kvantum"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland,x11"
        "GTK_USE_PORTAL,1"
      ];
    };
    extraConfig = ''
      # Mouse
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      # Kill
      bind=SUPER,q,killactive,
      bind=SUPER_SHIFT,E,exec,${pkgs.wlogout}/bin/wlogout

      # Exec
      bind=SUPER,return,exec,kitty
      bind=SUPER,d,exec,fuzzel
      bind=SUPER_SHIFT,print,exec,sh -c 'slurp | grim -g - -t png - | wl-copy -t image/png'
      bind=,print,exec,sh -c 'grim -g "$(slurp)" - | swappy -f -'
      bind=SUPER_SHIFT,x,exec,${pkgs.hyprlock}/bin/hyprlock

      # Float
      bind=SUPER_SHIFT,space,togglefloating,
      bind=SUPER,Tab,cyclenext,
      bind=SUPER,Tab,bringactivetotop,

      # Special
      bind=SUPER,minus,togglespecialworkspace,minus
      bind=SUPER_SHIFT,minus,movetoworkspace,special:minus
      bind=SUPER,equal,togglespecialworkspace,equal
      bind=SUPER_SHIFT,equal,movetoworkspace,special:equal

      # Master orientation
      bind=SUPER,F1,layoutmsg,orientationleft
      bind=SUPER,F2,layoutmsg,orientationright
      bind=SUPER,F3,layoutmsg,orientationtop
      bind=SUPER,F4,layoutmsg,orientationbottom
      bind=SUPER,F5,layoutmsg,orientationcenter

      # Master bindings
      bind=SUPER,i,layoutmsg, addmaster # add focused window to master stack
      bind=SUPER+SHIFT,i,layoutmsg, removemaster # add focused window to master stack
      bind=SUPER,m,layoutmsg,focusmaster

      # Master layout
      bind=SUPER,p,layoutmsg,cyclenext
      bind=SUPER,n,layoutmsg,cycleprev
      bind=SUPER_SHIFT,p,layoutmsg,swapnext
      bind=SUPER_SHIFT,n,layoutmsg,swapprev

      # Focus
      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d

      # Tab
      bind=SUPER,f,fullscreen,1
      bind=SUPER,g,togglegroup,
      bind=SUPER+SHIFT,g,moveoutofgroup,
      bind=SUPER,bracketleft,changegroupactive,f
      bind=SUPER,bracketright,changegroupactive,b

       # Media
      bind=,XF86AudioNext,exec,playerctl next
      bind=,XF86AudioPrev,exec,playerctl previous
      bind=,XF86AudioPlay,exec,playerctl play-pause
      bind=,XF86AudioStop,exec,playerctl stop
      bind=ALT,XF86AudioNext,exec,playerctld shift
      bind=ALT,XF86AudioPrev,exec,playerctld unshift
      bind=ALT,XF86AudioPlay,exec,systemctl --user restart playerctld
      bind=,XF86AudioLowerVolume,exec,pamixer -d 5
      bind=,XF86AudioMute,exec,pamixer -t
      bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
      bind=,XF86MonBrightnessDown,exec,light -U 5
      bind=,XF86MonBrightnessUp,exec,light -A 5

      # Moves
      bind=SUPER_SHIFT,h,movewindow,l
      bind=SUPER_SHIFT,l,movewindow,r
      bind=SUPER_SHIFT,k,movewindow,u
      bind=SUPER_SHIFT,j,movewindow,d
      bind=SUPER_SHIFT,1,submap,cws1
      bind=SUPER_SHIFT,2,submap,cws2
      bind=SUPER_SHIFT,3,submap,cws3
      bind=SUPER_SHIFT,4,movetoworkspace,40
      bind=SUPER_SHIFT,5,movetoworkspace,50
      bind=SUPER_SHIFT,6,movetoworkspace,60
      bind=SUPER_SHIFT,7,movetoworkspace,70
      bind=SUPER_SHIFT,8,submap,cws8
      bind=SUPER_SHIFT,9,movetoworkspace,90
      bind=SUPER_SHIFT,0,movetoworkspace,10

      # Workspaces
      bind=SUPER,1,submap,ws1
      bind=SUPER,2,submap,ws2
      bind=SUPER,3,submap,ws3
      bind=SUPER,4,workspace,40
      bind=SUPER,5,workspace,50
      bind=SUPER,6,workspace,60
      bind=SUPER,7,workspace,70
      bind=SUPER,8,submap,ws8
      bind=SUPER,9,workspace,90
      bind=SUPER,0,workspace,100

      # Resize submap
      bind=SUPER,R,submap,resize
      submap=resize
      bind=,l,resizeactive,30 0
      bind=,h,resizeactive,-30 0
      bind=,k,resizeactive,0 -30
      bind=,j,resizeactive,0 30
      bind=,escape,submap,reset
      submap=reset

      # Workspace submaps
      submap=ws1
      bind=SUPER,0,workspace,10
      bind=SUPER,0,submap,reset
      bind=,0,workspace,10
      bind=,0,submap,reset
      bind=SUPER,1,workspace,11
      bind=SUPER,1,submap,reset
      bind=,1,workspace,11
      bind=,1,submap,reset
      bind=SUPER,2,workspace,12
      bind=SUPER,2,submap,reset
      bind=,2,workspace,12
      bind=,2,submap,reset
      bind=SUPER,3,workspace,13
      bind=SUPER,3,submap,reset
      bind=,3,workspace,13
      bind=,3,submap,reset
      bind=SUPER,4,workspace,14
      bind=SUPER,4,submap,reset
      bind=,4,workspace,14
      bind=,4,submap,reset
      bind=SUPER,5,workspace,15
      bind=SUPER,5,submap,reset
      bind=,5,workspace,15
      bind=,5,submap,reset
      bind=SUPER,6,workspace,16
      bind=SUPER,6,submap,reset
      bind=,6,workspace,16
      bind=,6,submap,reset
      bind=SUPER,7,workspace,17
      bind=SUPER,7,submap,reset
      bind=,7,workspace,17
      bind=,7,submap,reset
      bind=SUPER,8,workspace,18
      bind=SUPER,8,submap,reset
      bind=,8,workspace,18
      bind=,8,submap,reset
      bind=SUPER,9,workspace,19
      bind=SUPER,9,submap,reset
      bind=,9,workspace,19
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=ws2
      bind=SUPER,0,workspace,20
      bind=,0,workspace,20
      bind=,0,submap,reset
      bind=SUPER,1,workspace,21
      bind=SUPER,1,submap,reset
      bind=,1,workspace,21
      bind=,1,submap,reset
      bind=SUPER,2,workspace,22
      bind=SUPER,2,submap,reset
      bind=,2,workspace,22
      bind=,2,submap,reset
      bind=SUPER,3,workspace,23
      bind=SUPER,3,submap,reset
      bind=,3,workspace,23
      bind=,3,submap,reset
      bind=SUPER,4,workspace,24
      bind=SUPER,4,submap,reset
      bind=,4,workspace,24
      bind=,4,submap,reset
      bind=SUPER,5,workspace,25
      bind=SUPER,5,submap,reset
      bind=,5,workspace,25
      bind=,5,submap,reset
      bind=SUPER,6,workspace,26
      bind=SUPER,6,submap,reset
      bind=,6,workspace,26
      bind=,6,submap,reset
      bind=SUPER,7,workspace,27
      bind=SUPER,7,submap,reset
      bind=,7,workspace,27
      bind=,7,submap,reset
      bind=SUPER,8,workspace,28
      bind=SUPER,8,submap,reset
      bind=,8,workspace,28
      bind=,8,submap,reset
      bind=SUPER,9,workspace,29
      bind=SUPER,9,submap,reset
      bind=,9,workspace,29
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=ws3
      bind=SUPER,0,workspace,30
      bind=,0,workspace,30
      bind=,0,submap,reset
      bind=SUPER,1,workspace,31
      bind=SUPER,1,submap,reset
      bind=,1,workspace,31
      bind=,1,submap,reset
      bind=SUPER,2,workspace,32
      bind=SUPER,2,submap,reset
      bind=,2,workspace,32
      bind=,2,submap,reset
      bind=SUPER,3,workspace,33
      bind=SUPER,3,submap,reset
      bind=,3,workspace,33
      bind=,3,submap,reset
      bind=SUPER,4,workspace,34
      bind=SUPER,4,submap,reset
      bind=,4,workspace,34
      bind=,4,submap,reset
      bind=SUPER,5,workspace,35
      bind=SUPER,5,submap,reset
      bind=,5,workspace,35
      bind=,5,submap,reset
      bind=SUPER,6,workspace,36
      bind=SUPER,6,submap,reset
      bind=,6,workspace,36
      bind=,6,submap,reset
      bind=SUPER,7,workspace,37
      bind=SUPER,7,submap,reset
      bind=,7,workspace,37
      bind=,7,submap,reset
      bind=SUPER,8,workspace,38
      bind=SUPER,8,submap,reset
      bind=,8,workspace,38
      bind=,8,submap,reset
      bind=SUPER,9,workspace,39
      bind=SUPER,9,submap,reset
      bind=,9,workspace,39
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=ws8
      bind=SUPER,0,workspace,80
      bind=SUPER,0,submap,reset
      bind=,0,workspace,80
      bind=,0,submap,reset
      bind=SUPER,1,workspace,81
      bind=SUPER,1,submap,reset
      bind=,1,workspace,81
      bind=,1,submap,reset
      bind=SUPER,2,workspace,82
      bind=SUPER,2,submap,reset
      bind=,2,workspace,82
      bind=,2,submap,reset
      bind=SUPER,3,workspace,83
      bind=SUPER,3,submap,reset
      bind=,3,workspace,83
      bind=,3,submap,reset
      bind=SUPER,4,workspace,84
      bind=SUPER,4,submap,reset
      bind=,4,workspace,84
      bind=,4,submap,reset
      bind=SUPER,5,workspace,85
      bind=SUPER,5,submap,reset
      bind=,5,workspace,85
      bind=,5,submap,reset
      bind=SUPER,6,workspace,86
      bind=SUPER,6,submap,reset
      bind=,6,workspace,86
      bind=,6,submap,reset
      bind=SUPER,7,workspace,87
      bind=SUPER,7,submap,reset
      bind=,7,workspace,87
      bind=,7,submap,reset
      bind=SUPER,8,workspace,88
      bind=SUPER,8,submap,reset
      bind=,8,workspace,88
      bind=,8,submap,reset
      bind=SUPER,9,workspace,89
      bind=SUPER,9,submap,reset
      bind=,9,workspace,89
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      # Move Submap
      submap=cws1
      bind=,0,movetoworkspace,10
      bind=,0,submap,reset
      bind=,1,movetoworkspace,11
      bind=,1,submap,reset
      bind=,2,movetoworkspace,12
      bind=,2,submap,reset
      bind=,3,movetoworkspace,13
      bind=,3,submap,reset
      bind=,4,movetoworkspace,14
      bind=,4,submap,reset
      bind=,5,movetoworkspace,15
      bind=,5,submap,reset
      bind=,6,movetoworkspace,16
      bind=,6,submap,reset
      bind=,7,movetoworkspace,17
      bind=,7,submap,reset
      bind=,8,movetoworkspace,18
      bind=,8,submap,reset
      bind=,9,movetoworkspace,19
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=cws2
      bind=,0,movetoworkspace,20
      bind=,0,submap,reset
      bind=,1,movetoworkspace,21
      bind=,1,submap,reset
      bind=,2,movetoworkspace,22
      bind=,2,submap,reset
      bind=,3,movetoworkspace,23
      bind=,3,submap,reset
      bind=,4,movetoworkspace,24
      bind=,4,submap,reset
      bind=,5,movetoworkspace,25
      bind=,5,submap,reset
      bind=,6,movetoworkspace,26
      bind=,6,submap,reset
      bind=,7,movetoworkspace,27
      bind=,7,submap,reset
      bind=,8,movetoworkspace,28
      bind=,8,submap,reset
      bind=,9,movetoworkspace,29
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=cws3
      bind=,0,movetoworkspace,30
      bind=,0,submap,reset
      bind=,1,movetoworkspace,31
      bind=,1,submap,reset
      bind=,2,movetoworkspace,32
      bind=,2,submap,reset
      bind=,3,movetoworkspace,33
      bind=,3,submap,reset
      bind=,4,movetoworkspace,34
      bind=,4,submap,reset
      bind=,5,movetoworkspace,35
      bind=,5,submap,reset
      bind=,6,movetoworkspace,36
      bind=,6,submap,reset
      bind=,7,movetoworkspace,37
      bind=,7,submap,reset
      bind=,8,movetoworkspace,38
      bind=,8,submap,reset
      bind=,9,movetoworkspace,39
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

      submap=cws8
      bind=,0,movetoworkspace,80
      bind=,0,submap,reset
      bind=,1,movetoworkspace,81
      bind=,1,submap,reset
      bind=,2,movetoworkspace,82
      bind=,2,submap,reset
      bind=,3,movetoworkspace,83
      bind=,3,submap,reset
      bind=,4,movetoworkspace,84
      bind=,4,submap,reset
      bind=,5,movetoworkspace,85
      bind=,5,submap,reset
      bind=,6,movetoworkspace,86
      bind=,6,submap,reset
      bind=,7,movetoworkspace,87
      bind=,7,submap,reset
      bind=,8,movetoworkspace,88
      bind=,8,submap,reset
      bind=,9,movetoworkspace,89
      bind=,9,submap,reset
      bind=,escape,submap,reset
      bind=,return,submap,reset
      submap=reset

    '';
  };
}
