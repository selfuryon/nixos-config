{
  perSystem =
    { pkgs, ... }:
    let
      aspects = pkgs.writeShellApplication {
        name = "aspects";
        runtimeInputs = with pkgs; [
          ripgrep
          jq
          gawk
          coreutils
          git
        ];
        # awk programs use $0 etc. inside single quotes on purpose
        excludeShellChecks = [ "SC2016" ];
        text = builtins.readFile ./aspects.sh;
      };
    in
    {
      devshells.default.commands = [
        {
          category = "Tools";
          name = "fmt";
          help = "Format the source tree";
          command = "nix fmt";
        }
        {
          category = "Tools";
          name = "check";
          help = "Nix flake check";
          command = "nix flake check";
        }
        {
          category = "Tools";
          help = "List flake.modules aspects and where they are imported";
          package = aspects;
        }
      ];
    };
}
