{ pkgs, ... }:
{
  home.persistence."/state/home/syakovlev".directories = [
    ".thunderbird"
  ];
  home.packages = with pkgs; [
    thunderbird
  ];
  # Running raw thunderbird due to this bug:
  # https://github.com/nix-community/home-manager/issues/6800
  # programs.thunderbird = {
  #   enable = true;
  #   profiles = {
  #     personal = {
  #       isDefault = true;
  #     };
  #   };
  # };
}
