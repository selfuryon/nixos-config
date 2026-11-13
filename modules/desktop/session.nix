{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {

      security.polkit.enable = true;
      # Polkit agent is DankMaterialShell's built-in one (see dms.nix).
      environment.systemPackages = with pkgs; [
        brightnessctl
        # polkitd only reads actions from the system profile; KeePassXC itself is a
        # home-manager package, so its Quick Unlock action must be linked here too.
        keepassxc
      ];

      services = {
        # gcr_3, not gcr_4: only the 3.x output ships the org.gnome.keyring.*Prompter
        # dbus services (upstream gnome-keyring.nix does the same).
        dbus.packages = [ pkgs.gcr_3 ];
      };

      services.gnome.gcr-ssh-agent.enable = false;
      programs.ssh.startAgent = true;

      hardware.graphics.enable = true;
    };
}
