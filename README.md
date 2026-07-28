# nix-darwin

[한국어](README-ko.md)

This repository manages macOS with `nix-darwin`, `home-manager`,
`nix-homebrew`, and `sops-nix`. It combines small aspect modules into
host-specific configurations and runs Home Manager inside nix-darwin.

## What this repo manages

- Flake setup and host configuration in `modules/flake/`
- Darwin and Home Manager aspects loaded from `modules/aspects/`
- Host declarations loaded from `hosts/`
- SOPS-encrypted files in `secrets/`, with rules in `.sops.yaml`
- Editor, browser, terminal, shell, desktop, SSH, and CLI configuration for
  user `poby`

## Prerequisites

- macOS on Apple Silicon (`aarch64-darwin`)
- Nix with flakes enabled (`nix-command` + `flakes`)
- `just` for running repository commands
- `nh` for the switch, update, debug, and cleanup commands
- A SOPS age key at:

```bash
$HOME/.config/sops/age/keys.txt
```

## Repository layout

- `flake.nix`: `flake-parts` entrypoint and flake inputs
- `Justfile`: repository commands (`dry-run`, `switch`, `update`, `debug`,
  `fmt`, `up`, `upp`, `repl`, `history`, `clean`, `gcroot`)
- `modules/flake/`: repository options, Darwin configuration assembly, and
  shared context modules
- `modules/aspects/`: public aspect entry modules such as `base`, `homebrew`,
  `shell`, `browser`, `discord`, `editor`, and `desktop`
- `modules/aspects/_*/`: private implementation trees imported by their public
  aspect modules
- `modules/aspects/_hammerspoon/`: Hammerspoon configuration linked to
  `$HOME/.hammerspoon`
- `modules/aspects/_editor/`: NVF and Zed configuration
- `modules/aspects/_browser/`: Zen Browser policies, profile settings,
  extensions, containers, spaces, and pinned tabs
- `modules/aspects/_secrets/`: `sops-nix` declarations, age key setup, and the
  Home Manager `SOPS_AGE_KEY_FILE` session variable
- `hosts/`: host declarations with a `system` value and a flat `features` list
- `dotfiles/`: exported application settings that Nix modules do not load
- `secrets/`: encrypted files grouped by purpose (`github.yaml`, `ssh.yaml`)

## Common commands

```bash
# List available tasks
just

# Build and switch the configuration for the current hostname
just switch $(hostname)

# Build and switch with detailed logs
just debug $(hostname)

# Evaluate dependencies without building them
just dry-run fenrir

# Format Nix files from the repository root
just fmt .

# Update every flake input and switch
just update fenrir

# Update one flake input and switch
just update fenrir nixpkgs

# Update every flake input without switching
just up

# Update one flake input without switching
just upp nixpkgs

# Build without switching (example host: fenrir)
nix build .#darwinConfigurations.fenrir.system \
  --accept-flake-config \
  --extra-experimental-features 'nix-command flakes'

# Run the dry-run directly with Nix
nix build .#darwinConfigurations.fenrir.system \
  --dry-run \
  --accept-flake-config \
  --extra-experimental-features 'nix-command flakes'

# Inspect the system profile history
just history

# Remove old generations and unused store paths
just clean

# Inspect automatic GC roots
just gcroot
```

## Configuration notes

- `flake.nix` uses `flake-parts` and imports `./modules/flake` directly.
  `import-tree` loads `./modules/aspects` and `./hosts`.
- `hosts/fenrir.nix` and `hosts/huginn.nix` define the available macOS hosts,
  each with one flat feature list.
- `modules/flake/darwin-configurations.nix` creates each
  `darwinConfigurations.<host>` output and adds Home Manager for user `poby`.
- `modules/aspects/` defines the features a host can select: `base`,
  `nix-core`, `system-packages`, `homebrew`, `macos-defaults`, `activation`,
  `fonts`, `sudo-auth`, `shell`, `cli-tools`, `git`, `ssh`, `secrets`,
  `terminal`, `hammerspoon`, `editor`, `browser`, `discord`, `desktop`,
  `fenrir`, and `huginn`.
- The `cli-tools` aspect configures CLI tools for the user, including
  `marp-cli` and `zoxide`.
- The `editor` aspect imports NVF and Zed. Home Manager manages Zed but leaves
  user settings, keymaps, tasks, and debug configuration mutable. Zed uses the
  `nix` extension. Its Nix language server is `nixd`, and its formatter is
  Alejandra.
- The `browser` aspect manages Zen Browser policies and imports the profile
  modules under `modules/aspects/_browser/`.
- The `homebrew` aspect installs Hammerspoon. The `hammerspoon` aspect links
  `modules/aspects/_hammerspoon/` to `$HOME/.hammerspoon` through Home Manager.
- `import-tree` skips paths containing `/_`. This keeps implementation files
  under `modules/aspects/_*/`, including the NVF source, out of automatic
  loading.
- nix-darwin hosts Home Manager, so the flake does not expose a standalone
  `homeConfigurations` output.

## Adding a host

- Create `hosts/<hostname>.nix`.
- Set `repo.hosts.<hostname>.system`.
- List the required aspects in `repo.hosts.<hostname>.features`.
- Put host-specific behavior in a new aspect under `modules/aspects/` instead
  of changing a shared feature.

## Secrets

- Keep secrets encrypted in `secrets/*.yaml`.
- `.sops.yaml` defines the encryption rules for `secrets/.*\.yaml`.
- The `secrets` aspect reads:
  - `secrets/github.yaml`: `github_ssh_key`, `github_cli_token`
  - `secrets/ssh.yaml`: `kmeat_mac_mini_ssh_key`

## Troubleshooting

- Run `just debug <hostname>` for detailed evaluation and build logs.
- If a host fails to evaluate, check that it exists in
  `darwinConfigurations`.
- Run `just dry-run <hostname>` to check evaluation and dependency resolution
  without switching.
- If a successful build leaves stale settings, run
  `just switch <hostname>` again and check the active hostname and
  configuration values.
