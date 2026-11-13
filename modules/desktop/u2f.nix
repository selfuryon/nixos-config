{
  # YubiKey touch for polkit prompts only (e.g. KeePassXC Quick Unlock).
  # Global security.pam.u2f.enable stays off so login/sudo/greeter are untouched;
  # its control/settings still apply to the per-service rule below.
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      security.pam = {
        u2f = {
          control = "sufficient"; # touch is enough; password stays as fallback
          settings.cue = true;
        };
        services.polkit-1.u2f.enable = true;
      };

      environment.systemPackages = [ pkgs.pam_u2f ]; # pamu2fcfg
    };

  flake.modules.homeManager.desktop = {
    # pam_u2f reads ~/.config/Yubico/u2f_keys; register keys with pamu2fcfg.
    my.persist.directories = [ ".config/Yubico" ];
  };
}
