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
    #scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
    scheme = {
      slug = "catppuccin-latte";
      scheme = "catppuccin latte";
      author = "selfuryon";
      base00 = "eff1f5"; # base
      base01 = "e6e9ef"; # mantle
      base02 = "ccd0da"; # surface0
      base03 = "bcc0cc"; # surface1
      base04 = "acb0be"; # surface2
      base05 = "4c4f69"; # text
      base06 = "dc8a78"; # rosewater
      base07 = "7287fd"; # lavender
      base08 = "d20f39"; # red
      base09 = "fe640b"; # peach
      base0A = "df8e1d"; # yellow
      base0B = "40a02b"; # green
      base0C = "179299"; # teal
      base0D = "1e66f5"; # blue
      base0E = "8839ef"; # mauve
      base0F = "dd7878"; # flamingo
    };
  };
}
