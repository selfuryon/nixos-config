[![Nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Nix/NixOS&color=5277C3&style=for-the-badge)](https://nixos.org/)

# My NixOS configurations (Flake)

Here is my NixOS/home-manager configuration.

Some highlights:

- [flake.parts](https://flake.parts/) with the [dendritic pattern](https://github.com/mightyiam/dendritic)
- [niri](https://github.com/YaLTeR/niri) + [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
- ZFS root with [impermanence](https://github.com/nix-community/impermanence), secure boot via [lanzaboote](https://github.com/nix-community/lanzaboote)

## Structure

Every `.nix` file under `modules/` is a flake-parts module, loaded automatically
by [import-tree](https://github.com/vic/import-tree) (paths starting with `_`
are skipped). Files are grouped by feature, not by configuration class: a file
contributes to one or more _aspects_ `flake.modules.<class>.<aspect>`, where
`<class>` is `nixos` or `homeManager`. One file may configure the same feature
for both classes (e.g. `desktop/niri.nix`).

- `flake` – flake-level setup: systems, devshell, formatter, pre-commit hooks
- `system` – `nixos.base` plus optional aspects (`tailscale`, `impermanence`, `netbird`, `printer`)
- `desktop` – `nixos.desktop` and `homeManager.desktop`: niri, DMS, browsers, terminals, apps
- `cli` – `homeManager.cli`: shells, editors, git, kubernetes tooling
- `home` – home-manager wiring and `homeManager.base` options (`my.persist`, font profile)
- `theme` – catppuccin for both classes
- `users` – `nixos.<user>` aspects
- `hosts/<name>` – `nixos.<name>` aspect and `nixosConfigurations.<name>`; a host imports the aspects it needs

Programs declare the paths they want persisted via `my.persist.directories`
next to their config; hosts with the `impermanence` aspect map them into
`home.persistence`.

Inspiration:

- https://github.com/mightyiam/dendritic
- https://github.com/Misterio77/nix-config
- https://github.com/balsoft/nixos-config
