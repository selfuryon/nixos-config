{ pkgs, config, ... }: {
  home.packages = with pkgs; [ wofi ];

  xdg.configFile."wofi/config".text = ''
    allow_images=false
    width=50%
    dynamic_lines=true
    line_wrap=word
    term=${pkgs.alacritty}/bin/alacritty
    allow_markup=true
    always_parse_args=true
    show_all=true
    print_command=true
    layer=overlay
    insensitive=true
    prompt=
    display_generic=true
  '';

  # https://git.sr.ht/~knezi/base16-wofi
  xdg.configFile."wofi/style.css".text = with config.scheme.withHashtag; ''
    window {
    	background-color: ${base00};
    	color: ${base05};
    }
    #entry:selected {
    	border-color: ${base0A}; 
    }
    #input {
    	background-color: ${base00};
    	border-color: ${base02}; 
    }
    #input:focus {
    	border-color: ${base0A}; 
    }
  '';
}
