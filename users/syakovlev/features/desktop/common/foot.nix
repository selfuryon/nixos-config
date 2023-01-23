{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=13";
        dpi-aware = "no";
      };
      scrollback = {lines = 10000;};
      cursor = {
        style = "beam";
        blink = "yes";
      };
      colors = {
        alpha = 1.0;
        background = "0xffffff";
        foreground = "0x586069";
        regular0 = "0x697179";
        regular1 = "0xd03d3d";
        regular2 = "0x14ce14";
        regular3 = "0x949800";
        regular4 = "0x0451a5";
        regular5 = "0xbc05bc";
        regular6 = "0x0598bc";
        bright0 = "0x666666";
        bright1 = "0xcd3131";
        bright2 = "0x14ce14";
        bright3 = "0xb5ba00";
        bright4 = "0x0451a5";
        bright5 = "0xbc05bc";
        bright6 = "0x0598bc";
        bright7 = "0x586069";
      };
    };
  };
}
