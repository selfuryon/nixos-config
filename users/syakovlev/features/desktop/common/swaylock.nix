{ pkgs, ... }: {
  home.packages = with pkgs; [ swaylock ];
  xdg.configFile."swaylock/config".text = ''
    image=/home/syakovlev/Pictures/lock.jpg
    scaling=fill
    font=Inner
    font-size=16
    indicator-caps-lock
    indicator-radius=50
    indicator-thickness=10
  '';
}