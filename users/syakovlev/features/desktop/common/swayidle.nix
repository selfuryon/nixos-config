{ pkgs, ... }:
let hyprctl = "${pkgs.hyprland}/bin/hyprctl";
in {
  services.swayidle = {
    enable = true;
    events = [{
      event = "before-sleep";
      command = "swaylock -f";
    }];
    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f";
      }
      {
        timeout = 600;
        command = "${hyprctl} 'output * dpms off'";
        resumeCommand = "${hyprctl} 'output * dpms on'";
      }
    ];
  };
}
