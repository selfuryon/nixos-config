{
  home.persistence."/state/home/syakovlev".directories = [
    ".thunderbird/personal"
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
