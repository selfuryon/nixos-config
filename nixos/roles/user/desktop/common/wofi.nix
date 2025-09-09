{
  pkgs,
  config,
  ...
}:
{
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
      border: 2px solid ${base0C};
    	background-color: ${base00};
    	color: ${base05};
      font-size: 15pt;
      font-family: "${config.themes.fontProfile.regular.family}";
    }
    #outer-box {
      padding: 5px;
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
