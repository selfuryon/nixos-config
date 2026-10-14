{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      users.mutableUsers = false;

      environment.systemPackages = with pkgs; [
        vim
        sbctl
        git # needed by nix to fetch git+https:// flake inputs
      ];
      services.upower.enable = true;

      security.doas.enable = true;

      systemd.user.settings.Manager.DefaultLimitNOFILE = "infinity";

      nixpkgs.config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
        permittedInsecurePackages = [
          "electron-36.9.5"
          "pnpm-10.29.2"
        ];
      };
    };
}
