{ config, ... }:
{
  programs.swaylock = {
    enable = true;
    settings = with config.scheme; {
      image = "/home/syakovlev/Pictures/lock.jpg";

      font = config.themes.fontProfile.regular.family;
      font-size = 16;

      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 50;
      indicator-idle-visible = true;

      ring-color = "${base02}";
      inside-wrong-color = "${base08}";
      ring-wrong-color = "${base08}";
      key-hl-color = "${base0B}";
      bs-hl-color = "${base08}";
      ring-ver-color = "${base09}";
      inside-ver-color = "${base09}";
      inside-color = "${base01}";
      text-color = "${base07}";
      text-clear-color = "${base01}";
      text-ver-color = "${base01}";
      text-wrong-color = "${base01}";
      text-caps-lock-color = "${base07}";
      inside-clear-color = "${base0C}";
      ring-clear-color = "${base0C}";
      inside-caps-lock-color = "${base09}";
      ring-caps-lock-color = "${base02}";
      separator-color = "${base02}";
    };
  };
}
