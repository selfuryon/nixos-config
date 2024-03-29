[![Nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Nix/NixOS&color=5277C3&style=for-the-badge)](https://nixos.org/)

# My NixOS configurations (Flake)

Here is my NixOS/home-manager configuration.

Some highlights:

- Multiple different type hosts (notebook, vps, servers)
- [flake.parts](https://flake.parts/) as a framework
- [colmena](https://github.com/zhaofengli/colmena/) for deploying configuration
- [ragenix](https://github.com/yaxitech/ragenix) for secret management
- Mesh network via [netbird](https://netbird.io/)
- WM is [hyprland](https://hyprland.org/)

## Structure

My current flake structure:

- `nix` contains basic nix flake configuration like devShell, packages, applications, checks and so on:
  - `checks` contains additional checks for pre-commit hook and `nix flake check`
  - `control` manages `mission-control` configuration
  - `formatter` configures treefmt parameters
  - `shell` manages devShell configuration
  - `lib` extends nixpkgs.lib with additional functions
- `nixos` contains a bunch of configurations for NixOS hosts
  - `machines` contains folders with per host individual configurations like deploy, hardware and network.
  - `modules` contains different modules for `NixOS` and `home-manager`
  - `overlays` is overlays for nixpkgs
  - `roles` defines typical small suites used for the configuration of a `system` and `home-manager` modules
  - `secrets` contains age encrypted secrets for hosts
  - `users` manages a basic user configutaions

Inspiration:

- https://github.com/Misterio77/nix-config
- https://github.com/balsoft/nixos-config
- https://github.com/aldoborrero/templates
