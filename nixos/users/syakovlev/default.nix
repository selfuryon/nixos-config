{
  inputs,
  pkgs,
  roles,
  ...
}:
let
  userName = "syakovlev";
  shared = import ../shared.nix;
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "latte";
    accent = "blue";
  };
in
{
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
      "doas"
      "video"
      "audio"
      "libvirtd"
      "usb"
      "ssh"
      "wireshark"
    ];
    shell = pkgs.nushell;
    inherit (shared) hashedPassword;
    openssh.authorizedKeys.keys = shared.authorizedKeys;
  };

  inherit catppuccin;
  programs.fish.enable = true;

  home-manager.users.${userName} = {
    imports = [ roles.user.terminal.default ];

    catppuccin = catppuccin // {
      gtk.icon.enable = false;
    };
    programs.home-manager.enable = true;
    home.stateVersion = "26.11";
    scheme = "${inputs.tt-schemes}/base16/catppuccin-latte.yaml";
    services.podman = {
      enable = true;
      settings.storage.storage = {
        graphroot = "/containers/${userName}";
      };
    };
  };
}
