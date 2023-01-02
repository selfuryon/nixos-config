{ pkgs, ... }: {
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

  xdg.configFile."wofi/style.css".text = ''
    #window {
      background-color: #ffffff;
      padding: 5px;
      border: 1px solid black;
      border-radius: 10px;
    }
    #input {
      background-color: #ffffff;
      border: 1px solid;
    }
    #entry {
      color: #24292f;
      padding: 10px;
    }
    #entry:selected {
      color: #ffffff;
      background-color: #0969da;
    }
  '';
}
