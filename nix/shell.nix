{
  perSystem =
    {
      pkgs,
      config,
      ...
    }:
    let
      inherit (pkgs) statix talosctl kubernetes-helm;
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
        ];
        devshell.startup = {
          pre-commit.text = config.pre-commit.installationScript;
        };
      };
    };
}
