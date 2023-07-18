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
    openssh.authorizedKeys.keyFiles = [./keys.pub];
  };

  programs.fish.enable = true;

  security.sudo.extraRules = [
    {
      users = ["${userName}"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD" "SETENV"];
        }
      ];
    }
  ];

  security.doas.extraRules = [
    {
      users = ["${userName}"];
      noPass = true;
    }
  ];

  home-manager.users.${userName} = {
    imports = [
      inputs.base16.homeManagerModule
      roles.user.terminal.default
    ];
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
  };
}
