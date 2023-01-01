{ inputs, hostname, pkgs, lib, ... }:
let
  userName = "syakovlev";
  hostConfig =
    builtins.filter (p: builtins.pathExists p) [ ./${hostname}.nix ];
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ./features/global ]
    ++ hostConfig;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "sudo" "doas" "video" "audio" "libvirtd" "usb" "ssh" ];
    shell = pkgs.fish;
    hashedPassword =
      "$6$skRJZuaIN8S0Ohgf$UwgLyx9DGZ8acjl/EwsaEnecPSZAwAwp42NS449CQpoLaGZKK7uo2GdiF0Tl6eMfIg6gxz5Rb6rudC34r5V0C/";
    openssh.authorizedKeys.keyFiles =
      [ ./keys/${hostname}.pub ./keys/yubikeys.pub ];
  };

  security.sudo.extraRules = [{
    users = [ "${userName}" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" "SETENV" ];
    }];
  }];

  security.doas.extraRules = [{
    users = [ "${userName}" ];
    noPass = true;
  }];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "megasync"
      "slack"
      "discord"
      "skypeforlinux"
      "languagetool"
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${userName} = {
      programs.home-manager.enable = true;
      home.stateVersion = "23.05";
    };
  };
}
