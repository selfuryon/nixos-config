{
  inputs,
  hostname,
  pkgs,
  roles,
  ...
}: let
  userName = "syakovlev";
  # TODO: statix parses paths like `./${hostname}.nix` wrong: https://github.com/nerdypepper/statix/issues/68
  hostConfig = builtins.filter builtins.pathExists [(./. + "/${hostname}.nix")];
in {
  imports = hostConfig;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = ["wheel" "sudo" "doas" "video" "audio" "libvirtd" "usb" "ssh"];
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
    #scheme = "${inputs.base16-schemes}/google-light.yaml";
    scheme = {
      slug = "github-light";
      scheme = "Light theme";
      author = "selfuryon";
      base00 = "ffffff"; # Default Background
      base01 = "f5f5f5"; # Lighter Background (Used for status bars)
      base02 = "c8c8fa"; # Selection Background
      base03 = "969896"; # Comments, Invisibles, Line Highlighting
      base04 = "e8e8e8"; # Dark Foreground (Used for status bars)
      base05 = "333333"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "ffffff"; # Light Foreground (Not often used)
      base07 = "ffffff"; # Light Foreground (Not often used)
      base08 = "cc342b"; # Red
      base09 = "0086b3"; # Orange
      base0A = "fba922"; # Yellow
      base0B = "198844"; # Green
      base0C = "3971ed"; # Cyan
      base0D = "3971ed"; # Blue
      base0E = "a36ac7"; # Magenta
      base0F = "333333"; # Brown
    };
  };
}
