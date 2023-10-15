{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  programs.fuse.userAllowOther = true;
  environment.persistence."/state/system" = {
    hideMounts = true;
    directories = [
      {
        directory = "/etc/secureboot";
        mode = "u=rwx,g=rx,o=";
      }
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
  system.activationScripts."10-persistent-dirs".text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /state/home/${user.name}
        chown ${user.name}:${user.group} /state/home/${user.name}
        chmod ${user.homeMode} /state/home/${user.name}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);
}
