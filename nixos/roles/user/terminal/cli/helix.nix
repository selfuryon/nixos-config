{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nodePackages.prettier
    rust-analyzer
    gopls
    nil
    yaml-language-server
  ];
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "alejandra";
            args = [];
          };
        }
      ];
    };
    settings = {
      theme = "github_light";
      keys.normal = {space.space = "file_picker";};
      editor = {
        auto-save = true;
        true-color = true;
        color-modes = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
