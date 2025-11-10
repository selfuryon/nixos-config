{
  perSystem =
    {
      pkgs,
      # inputs',
      config,
      ...
    }:
    let
      inherit (pkgs) statix talosctl kubernetes-helm;
      # inherit (inputs'.ragenix.packages) ragenix;
      # inherit (inputs'.colmena.packages) colmena;
    in
    {
      devshells.default = {
        name = "personal";
        env = [
          {
            name = "TALOSCONFIG";
            eval = "$PRJ_ROOT/.secrets/talos/config";

          }
          {
            name = "KUBECONFIG";
            eval = "$PRJ_ROOT/.secrets/kubernetes/config";
          }
        ];
        packages = [
          statix
          talosctl
          kubernetes-helm
          # ragenix
          # colmena
        ];
        devshell.startup = {
          pre-commit.text = config.pre-commit.installationScript;
        };
      };
    };
}
