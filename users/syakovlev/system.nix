{ pkgs, hostname, ... }: {
  users.users.syakovlev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "libvirtd" "usb" "ssh" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keyFiles = [ (./keys + "/${hostname}.pub") ];
  };

}
