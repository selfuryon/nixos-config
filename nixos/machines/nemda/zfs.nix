{
  services.zfs.trim.enable = true;
  services.zrepl = {
    enable = true;
    settings = {
      jobs = [
        {
          name = "snapshot";
          type = "snap";
          filesystems = {
            "zroot/state<" = true;
          };
          snapshotting = {
            type = "periodic";
            interval = "15m";
            prefix = "zrepl_";
          };
          pruning = {
            keep = [
              {
                type = "grid";
                grid = "1x1h(keep=all) | 24x1h | 7x1d | 4x1w";
                regex = "^zrepl_.*";
              }
              {
                type = "regex";
                negate = true;
                regex = "^zrepl_.*";
              }
            ];
          };
        }
      ];
    };
  };
}
