{ config, pkgs, ... }: {
  users.groups.ssh = { };

  security.sudo.extraRules = [{
    users = [ "syakovlev" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" "SETENV" ];
    }];
  }];
}
