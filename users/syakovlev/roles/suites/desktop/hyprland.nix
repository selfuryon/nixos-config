{ inputs, config, lib, pkgs, ... }:
let userName = "syakovlev";
in {
  home-manager.users.${userName} = {
    imports = [ inputs.hyprland.homeManagerModules.default ];
    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = false;
      extraConfig = ''
        monitor=eDP-1,1920x1080,0x0,1
        monitor=,preferred,auto,1
        general {
          main_mod=SUPER
          gaps_in=15
          gaps_out=30
          border_size=2
          col.active_border=0xffc0caf5
          col.inactive_border=0xffc0caf5
          damage_tracking=full
        }

        decoration {
          rounding=12
          multisample_edges=true
          blur=true
          blur_size=12 # minimum 1
          blur_passes=3 # minimum 1
          blur_new_optimizations=1
          drop_shadow=true
          shadow_range=20
          shadow_render_power	= 3
          dim_inactive = true
          dim_strength = .105
        }

        animations {
          enabled=true
          animation=windows,1,7,default
          animation=border,1,10,default
          animation=fade,1,10,default
          animation=workspaces,1,6,default
        }

        input {
          kb_layout=us,ru
          kb_options=grp:shift_caps_switch
          follow_mouse=0
        }

        dwindle {
          force_split=2
          pseudotile=0 # enable pseudotiling on dwindle
        }

        # Workspaces
        bind=SUPER,1,workspace,1
        bind=SUPER,2,workspace,2
        bind=SUPER,3,workspace,3
        bind=SUPER,4,workspace,4
        bind=SUPER,5,workspace,5
        bind=SUPER,6,workspace,6
        bind=SUPER,7,workspace,7
        bind=SUPER,8,workspace,8
        bind=SUPER,9,workspace,9
        bind=SUPER,0,workspace,10
        
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

        bind=SUPERSHIFT,1,movetoworkspace,1
        bind=SUPERSHIFT,2,movetoworkspace,2
        bind=SUPERSHIFT,3,movetoworkspace,3
        bind=SUPERSHIFT,4,movetoworkspace,4
        bind=SUPERSHIFT,5,movetoworkspace,5
        bind=SUPERSHIFT,6,movetoworkspace,6
        bind=SUPERSHIFT,7,movetoworkspace,7
        bind=SUPERSHIFT,8,movetoworkspace,8
        bind=SUPERSHIFT,9,movetoworkspace,9
        bind=SUPERSHIFT,0,movetoworkspace,10

        # Media
        bind=,XF86AudioLowerVolume,exec,pamixer -d 5
        bind=,XF86AudioMute,exec,pamixer -t
        bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
        bind=,XF86MonBrightnessDown,exec,light -U 5
        bind=,XF86MonBrightnessUp,exec,light -A 5

        # System
        bind=SUPER,T,togglefloating,
        bind=SUPERSHIFT,R,exec,hyprctl reload
        bind=SUPERSHIFT,E,exec,pkill Hyprland
        bind=SUPERSHIFT,Q,killactive
        bind=SUPER,return,exec,alacritty
        bind=SUPER,D,exec,wofi --show drun
        bind=SUPER,P,pseudo,
        bind=SUPERSHIFT,print,exec,sh -c 'slurp | grim -g - -t png - | wl-copy -t image/png'
        bind=,print,exec,sh -c 'grim -g "$(slurp)" - | swappy -f -'

        # Split
        bind=SUPER,E,togglegroup,
        bind=ALT,L,changegroupactive,f
        bind=ALT,H,changegroupactive,b
        bind=ALT,S,togglesplit,

        # Resize Mode with Alt + R : Press Escape to quit
        bind=SUPER,R,submap,resize # will switch to a submap called resize
        submap=resize # will start a submap called "resize"

        bind=,l,resizeactive,30 0
        bind=,h,resizeactive,-30 0
        bind=,k,resizeactive,0 -30
        bind=,j,resizeactive,0 30

        bind=,escape,submap,reset # use reset to go back to the global submap
        submap=reset # will reset the submap, meaning end the current one and return to the global one.
      '';
    };
  };
}
