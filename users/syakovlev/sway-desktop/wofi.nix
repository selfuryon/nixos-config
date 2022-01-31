{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    wofi
  ];

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
  #entry {
    /* background-color: transparent; */
    border-radius: 3;
    padding: 2px 3px 2px 3px;
  }

  #entry:selected {
    background-color: #5e81ac;
    /* border: none; */
  }
  
  #text:selected {
    color: #d8dee9;
    font-weight: bold;
  }
  
  #window {
    padding: 2px;
    background-color: rgba(53,59,73,0.97);
    border: 3px solid #3b4252;
    border-radius: 2px;
    font-family: JetBrainsMono Nerd Font Mono
  }

  #input {
    text-align: center;
    border: 2px solid #5e81ac;
    background-color: #4c566a;
    padding: 3 5 3 5;
    border-radius: 5px;
  }

  #inner-box {
    color: #d8dee9;
    padding: 2px;
    background-color: transparent;
  }

  #outer-box {
    margin: 15px;
    background-color: transparent;
  }

  #scroll {
    margin-top: 10px;
    background-color: none;
    border: none;
  }

  #text {
    padding: 6px;
    font-size: 16px;
    background-color: transparent;
  } 

  #img {
    background-color: transparent;
    padding: 5px;
  }
  '';
}
