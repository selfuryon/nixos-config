{ inputs, hostname, users, pkgs, ... }:
let
  userName = "syakovlev";
  features = users.${userName}.features;
  lib = inputs.nixpkgs.lib;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" "ssh" ];
    shell = pkgs.fish;
    hashedPassword =
      "$6$skRJZuaIN8S0Ohgf$UwgLyx9DGZ8acjl/EwsaEnecPSZAwAwp42NS449CQpoLaGZKK7uo2GdiF0Tl6eMfIg6gxz5Rb6rudC34r5V0C/";
    openssh.authorizedKeys.keyFiles = [ (./keys + "/${hostname}.pub") ];
  };

  security.sudo.extraRules = [{
    users = [ "syakovlev" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" "SETENV" ];
    }];
  }];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "megasync"
      "slack"
      "discord"
      "skypeforlinux"
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    #_module.args = { inherit inputs; };
    users.${userName} = {
      imports = lib.forEach features (f: ./features + "/${f}");
      programs.home-manager.enable = true;
      home.stateVersion = "22.05";
    };

  };

}
