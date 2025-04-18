{
  home.persistence."/state/home/syakovlev".directories = [
    ".thunderbird"
  ];
  programs.thunderbird = {
    enable = true;
    profiles = {
      personal = {
        isDefault = true;
      };
    };
  };
}
