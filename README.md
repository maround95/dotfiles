# target-first starter

This starter uses three top-level concepts:

- `core/` for flake infrastructure
- `modules/` for shared reusable logic
- `outputs/` for the explicit flake output graph

## Minimal model

The starter keeps the architecture intentionally small:

- `outputs/` is primary: it defines the concrete graph the flake exposes
- `modules/` is a shared library: reusable platforms, profiles, and other shared modules
- `core/` provides infrastructure: package-set constructors, overlays, constructors, target facts, and the base `custom.lib`

Inside `modules/`, the only strongly distinguished shared families are:

- `platforms/`
- `profiles/`

Other shared reusable modules can live directly under `modules/` when that keeps the graph clearer.

## Package and channel model

- `core/pkgs.nix` owns the per-system channel context through flake-parts `perSystem`
- `pkgsByChannel` is lazy and contains the named package sets: `stable`, `unstable`, and `unstable-small`
- `pkgsFor` is the explicit secondary-channel escape hatch
- output constructors still choose a `mainChannel` explicitly from that shared per-system channel context
- modules receive:
  - `pkgs` as the selected output main channel
  - `pkgsFor` as a module argument for explicit access to alternate named channels

## Target facts and shared lib

`core/target.nix` provides:

- `custom.target` with stable target-wide facts:
  - `host`
  - `platform`
  - `kind`
  - `os`
  - `system`
- `custom.lib`, an extensible namespaced helper surface inside the module graph

The starter seeds only:

- `custom.lib.module.*`
- `custom.lib.target.*`

Modules should prefer contributing leaves when extending `custom.lib`.

## Current concrete example

Ares is the first concrete output and embeds Home Manager explicitly under:

- `outputs/nixos/ares/default.nix`
- `outputs/nixos/ares/home/maroun.nix`
- `outputs/nixos/ares/home/root.nix`


## Desktop default-session policy

The starter now includes a shared NixOS desktop session contract at `modules/desktop/default-session.nix`.
Desktop environment modules can contribute session definitions under `custom.desktop.sessions.<name>`, and if more than one session is enabled, `custom.desktop.preferred` must be set to one of those names.

Derived values are exposed at:
- `custom.desktop.displayManager.defaultSession`
- `custom.desktop.displayManager.defaultSessionCmd`

## Overlays

Global overlays are intentionally empty for now. Local packages and external flake packages should be referenced explicitly rather than injected into every `pkgs` set.

- The public model is `pkgs` for the output's `mainChannel`, plus a lazy `pkgsFor` module argument for rare secondary-channel access.
- Package sets are intentionally not stored under `config.custom.*`.
- Cross-channel packages should use `pkgsFor "channel"` at the exact aspect/package site that needs them.
- True overlays should be reserved for package-set-wide transformations.

## Optional secrets flake

The public flake can consume an optional `secrets` input without knowing the
private repo's internal file layout. If the input is present, constructors and
embedded Home Manager subfiles import layered module lists from a small public
export contract. Missing paths return `[]`, so behavior is unchanged when the
input or a layer is absent.

The lookup shape is:

```nix
inputs.secrets.modules.secrets.<family>.<system>.common
inputs.secrets.modules.secrets.<family>.<system>.outputs.<outputName>
inputs.secrets.modules.secrets.home.<system>.outputs.<outputName>.users.<user>
```

Where:

- `family` is `nixos`, `home`, or `darwin`
- `system` is a Nix system string such as `x86_64-linux`
- `outputName` is the main flake output name, such as `ares` or `ares-vm`
- `user` is the Home Manager user key, only for Home Manager graphs

Modules are imported from general to specific:

1. family/system `common`
2. output-specific modules
3. Home Manager user-specific modules

Examples:

```nix
# Applies to all x86_64-linux NixOS outputs.
modules.secrets.nixos.x86_64-linux.common = [ ./nixos/common.nix ];

# Applies only to nixosConfigurations.ares.
modules.secrets.nixos.x86_64-linux.outputs.ares = [ ./nixos/ares.nix ];

# Applies to all x86_64-linux Home Manager graphs.
modules.secrets.home.x86_64-linux.common = [ ./home/common.nix ];

# Applies to all HM users under nixosConfigurations.ares.
modules.secrets.home.x86_64-linux.outputs.ares = [ ./home/ares.nix ];

# Applies only to home-manager.users.maroun under nixosConfigurations.ares.
modules.secrets.home.x86_64-linux.outputs.ares.users.maroun = [ ./home/ares-maroun.nix ];
```

Those secrets modules join the same module graph, so they can use `pkgs`,
`config.custom.target`, `config.custom.lib`, `pkgsFor`, and in
Home Manager graphs, `home.username` / optional `custom.home.identity`.

The secrets repo can stay tiny by exporting only `common`, or it can add
selected output/user hooks later without changing the main flake.


## Constructor contract

Constructors build output evaluations; output files still own composition.

- `mkNixosOutput` takes an explicit `target` attrset. The output name and host
  identity do not have to be the same, which keeps variants like `ares-vm`
  clean.
- `mkHomeOutput` separates the flake output `name` from the local Home Manager
  `user`. HM owns the actual local username through `home.username`; this repo
  only adds optional `custom.home.identity` for reusable persona/profile
  identity across machines.

## Ares host-local boundary

Ares imports its disk layout and laptop hardware files directly from `outputs/nixos/ares/`:

- `disko_config.nix` owns the disk layout.
- `l5p-16ach6h/` owns Legion 5 Pro hardware/specialisation config.
- `local.nix` owns host facts copied from the old Ares system file: hostname, state version, generated hardware-configuration facts, firmware/microcode, usbmuxd, and host-only packages.

These are intentionally host-local files, not reusable aspects.


## Latest slice

- Added NixOS Wayland and Hyprland aspects.
- `profile-desktop-hyprland` now imports those aspect faces instead of enabling Hyprland inline.
- Ares explicitly selects `custom.desktop.preferred = "hyprland"`.
- The Home Manager Hyprland face is intentionally a placeholder for the next slice.


## Current migration slice: greetd

- Added `modules/aspects/greetd.nix`.
- `profile-desktop-hyprland` now imports `nixos.greetd`.
- greetd consumes `custom.desktop.displayManager.defaultSessionCmd` from the session collector.
- Ares sets `custom.desktop.displayManager.greetd.user = "maroun"`.


## Latest slice

Added HM desktop support daemons: dunst, swww, and swayosd.

## Latest slice: Kitty HM aspect

- Added `modules/aspects/kitty.nix`.
- Added `flake.modules.homeManager.kitty`.
- Imported Kitty into `profile-desktop-hyprland`.
- Kept the settings close to the old Snowfall Kitty module.


## Current migration slice

- Added minimal Home Manager Firefox aspect.
- Firefox is imported by the Hyprland desktop profile.
- Betterfox, addons, and CSS hacks are intentionally postponed.

## Wallust slice

The HM desktop profile now imports `flakeModules.homeManager.wallust` after the base theme.
Wallust owns:

- `custom.wallust.package`
- `custom.wallust.settings`
- colorscheme links under `~/.config/wallust/colorschemes`
- templates for Kitty, Rofi, Waybar, Hyprland, and Dunst
- first-activation colorscheme generation using `custom.theme.colorscheme`

The existing app aspects remain responsible for their own config, but consume generated Wallust outputs where needed.


## System-common completion slice

Added base NixOS aspects for nix settings, sudo, polkit, sops, audio, bluetooth, ntp, console/env/fonts/latest-kernel/xkb, nix-ld, and common tools. These are wired through `profile-common`.

## Shell/dev HM slice 1

Ported lightweight Home Manager shell/development aspects:

- direnv
- readline/inputrc
- starship
- zoxide
- lazygit
- yazi
- zellij, including old config/layout files

Heavier old modules remain next:

- tmux, because old config depends on custom tmux tools and mvim package metadata
- nvim/mvim, because old config depends on the old custom mvim package set/input wiring

## Port slice: HM nvim/mvim

- Added `modules/aspects/nvim.nix`.
- Added `nvim-maroun` input.
- Uses the input's `mvimPackages` overlay locally via `pkgs.extend`, not globally.
- Wires `mvim` into Maroun's shell profile and sets EDITOR/VISUAL.
- Wallust now emits the old `colors-wal.vim` template for Neovim consumers.
