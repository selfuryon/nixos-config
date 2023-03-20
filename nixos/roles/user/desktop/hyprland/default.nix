{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.hyprland.homeManagerModules.default ../common];
  home.packages = with pkgs; [
    wayland
    swaybg
    glib # gsettings
    qt5.qtwayland
    libsForQt5.lightly
    wlogout
  ];
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    #QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    _JAVA_AWT_WM_NONREPARENTING = 1;
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland,x11";
    GTK_USE_PORTAL = 1;
    #NIXOS_OZONE_WL = 1;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    extraConfig = with config.scheme; ''
      monitor=eDP-1,1920x1080,0x0,1
      monitor=HDMI-A-1,1920x1080,0x1080,1
      monitor=,preferred,auto,1
      workspace=eDP-1,11

      general {
        gaps_in=15
        gaps_out=20
        border_size=3
        cursor_inactive_timeout=4

        col.active_border=0xff${base0C}
        col.inactive_border=0xff${base02}
        col.group_border_active=0xff${base0B}
        col.group_border=0xff${base04}
      }
      decoration {
        active_opacity=1
        blur=true
        blur_ignore_opacity=true
        blur_new_optimizations=true
        blur_passes=3
        blur_size=6  # old 12
        dim_inactive = true
        dim_strength = .105
        drop_shadow=true
        fullscreen_opacity=1.0
        rounding=12
        shadow_offset=3 3
        shadow_range=12 # old 20

        inactive_opacity=0.80
        col.shadow=0x44000000
        col.shadow_inactive=0x66000000
      }
      animations {
        enabled=true
        bezier=easein,0.11, 0, 0.5, 0
        bezier=easeout,0.5, 1, 0.89, 1
        bezier=easeinout,0.45, 0, 0.55, 1
        animation=windowsIn,1,3,easeout,slide
        animation=windowsOut,1,3,easein,slide
        animation=windowsMove,1,3,easeout
        animation=fadeIn,1,3,easeout
        animation=fadeOut,1,3,easein
        animation=fadeSwitch,1,3,easeout
        animation=fadeShadow,1,3,easeout
        animation=fadeDim,1,3,easeout
        animation=border,1,3,easeout
        animation=workspaces,1,2,easeout,slide
      }
      input {
        kb_layout=us,ru
        kb_variant=,chm
        kb_options=grp:shift_caps_switch
        follow_mouse=0
        touchpad {
          natural_scroll=true
        }
      }
      dwindle {
        force_split=2
        pseudotile=0 # enable pseudotiling on dwindle
        no_gaps_when_only=false
        split_width_multiplier=1.35
      }
      # Mouse
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

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

      # Focus
      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d
      # Moves
      bind=SUPERSHIFT,h,movewindow,l
      bind=SUPERSHIFT,l,movewindow,r
      bind=SUPERSHIFT,k,movewindow,u
      bind=SUPERSHIFT,j,movewindow,d
      bind=SUPERSHIFT,1,submap,cws1
      bind=SUPERSHIFT,2,submap,cws2
      bind=SUPERSHIFT,3,submap,cws3
      bind=SUPERSHIFT,4,movetoworkspace,40
      bind=SUPERSHIFT,5,movetoworkspace,50
      bind=SUPERSHIFT,6,movetoworkspace,60
      bind=SUPERSHIFT,7,movetoworkspace,70
      bind=SUPERSHIFT,8,submap,cws8
      bind=SUPERSHIFT,9,movetoworkspace,90
      bind=SUPERSHIFT,0,movetoworkspace,10
      # Submap moves
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
      # System
      bind=SUPER,T,togglefloating,
      bind=SUPERSHIFT,space,togglefloating,
      bind=SUPERSHIFT,R,exec,hyprctl reload
      #bind=SUPERSHIFT,E,exec,pkill Hyprland
      bind=SUPERSHIFT,Q,killactive
      bind=SUPER,return,exec,alacritty
      bind=SUPER,D,exec,wofi --show drun
      bind=SUPER,P,pseudo,
      bind=SUPERSHIFT,print,exec,sh -c 'slurp | grim -g - -t png - | wl-copy -t image/png'
      bind=SUPERSHIFT,x,exec,${pkgs.swaylock}/bin/swaylock -f
      bind=,print,exec,sh -c 'grim -g "$(slurp)" - | swappy -f -'
      # Special
      bind=SUPER,minus,togglespecialworkspace,
      bind=SUPERSHIFT,minus,movetoworkspace,special

      # Split
      bind=SUPER,F,fullscreen,
      bind=SUPER,E,togglegroup,
      bind=SUPER,L,changegroupactive,f
      bind=SUPER,H,changegroupactive,b
      bind=SUPER,apostrophe,changegroupactive,f
      bind=SUPERSHIFT,apostrophe,changegroupactive,b

      # Resize Mode with Alt + R : Press Escape to quit
      bind=SUPER,R,submap,resize # will switch to a submap called resize
      submap=resize # will start a submap called "resize"
      bind=,l,resizeactive,30 0
      bind=,h,resizeactive,-30 0
      bind=,k,resizeactive,0 -30
      bind=,j,resizeactive,0 30
      bind=,escape,submap,reset # use reset to go back to the global submap
      submap=reset # will reset the submap, meaning end the current one and return to the global one.
      exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
      exec-once=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      exec-once=${pkgs.swaybg}/bin/swaybg -i /home/syakovlev/Pictures/wife2.jpg --mode fill

      windowrulev2=float,class:^(MEGAsync)$
      windowrulev2=float,size 0 0, move 10 10,title:(Sharing Indicator)
      windowrulev2=float,pin,class:(pavucontrol)
    '';
  };
}
