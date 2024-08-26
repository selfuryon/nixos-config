{
  inputs,
  pkgs,
  roles,
  ...
}: let
  userName = "syakovlev";
in {
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = ["wheel" "sudo" "doas" "video" "audio" "libvirtd" "usb" "ssh" "wireshark"];
    shell = pkgs.fish;
    hashedPassword = "$6$skRJZuaIN8S0Ohgf$UwgLyx9DGZ8acjl/EwsaEnecPSZAwAwp42NS449CQpoLaGZKK7uo2GdiF0Tl6eMfIg6gxz5Rb6rudC34r5V0C/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILIhSucTbstWJv0sC2tqoHB+f6HfsFR/nuUXLYPcRlGL sergey.y@default [private]"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOacgO1zUpZZQjFdgVjuJgZsTDATpAcgv1R2499P++FrAAAABHNzaDo= sergey.y@yubikey-blue [private]"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIC3+NdnJ1kFk8wxyJ/mI5giVwSbnLmzhcyO+/AdhcEcMAAAABHNzaDo= sergey.y@yubikey-grey [private]"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmAhDxyLiIA3qfjQerCP/lIdWHgzIYceQAytjlluRkK sergey.y@backup [private]"
    ];
  };

  catppuccin.flavor = "latte";
  catppuccin.accent = "mauve";
  programs.fish.enable = true;

  home-manager.users.${userName} = {
    imports = [
      inputs.catppuccin.homeManagerModules.catppuccin
      inputs.base16.homeManagerModule
      roles.user.terminal.default
    ];

    catppuccin.flavor = "latte";
    catppuccin.accent = "mauve";
    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
    scheme = "${inputs.tt-schemes}/base16/catppuccin-latte.yaml";
  };
}
