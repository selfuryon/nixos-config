{ pkgs, ... }: {
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
        command = ''swaymsg "output * dpms off"'';
        resumeCommand = ''swaymsg "output * dpms on "'';
      }
    ];
  };
}
