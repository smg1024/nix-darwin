# Secrets

This directory contains the SOPS-encrypted secrets used by the `secrets` Home
Manager aspect. Never commit plaintext secrets.

## Current setup

- Secret files:
  - `secrets/github.yaml`: GitHub SSH key and GitHub CLI token
  - `secrets/ssh.yaml`: non-GitHub SSH private keys
- SOPS rules: `.sops.yaml`
- Age key file: `~/.config/sops/age/keys.txt`
- Environment variable: the `secrets` aspect exports `SOPS_AGE_KEY_FILE`
- SOPS CLI: the system packages aspect installs it
- Secret declarations: `modules/aspects/_secrets/sops.nix`
- SSH host configuration: `modules/aspects/_ssh/ssh.nix`
- Declared secret names:
  - `github_ssh_key`
  - `github_cli_token`
  - `kmeat_mac_mini_ssh_key`

## Add an SSH private key

From the repository root, open the encrypted secret file:

```bash
sops secrets/ssh.yaml
```

After Home Manager applies the `secrets` aspect, it exports
`SOPS_AGE_KEY_FILE`. SOPS then uses `~/.config/sops/age/keys.txt` by default.

Add a top-level key and paste the private key as a YAML block scalar. Use the
same key name in the Nix declaration you add later.

```yaml
workstation_ssh_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  ...
  -----END OPENSSH PRIVATE KEY-----
```

Save and quit the editor. SOPS re-encrypts the file automatically.

Do not edit the `sops:` metadata block.

If SOPS cannot find the age key, pass the key file explicitly:

```bash
SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt" sops secrets/ssh.yaml
```

Before the system package set is active, open a temporary shell with `sops`:

```bash
nix-shell -p sops --run 'sops secrets/ssh.yaml'
```

## Generate a new SSH key first

If you do not have a key yet, generate one before opening SOPS:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/workstation_ssh_key -C "workstation"
```

Register the public key with the remote service:

```bash
cat ~/.ssh/workstation_ssh_key.pub
```

Then copy the private key into `secrets/ssh.yaml` with SOPS.

Once `sops-nix` deploys the key from SOPS, remove the temporary plaintext copy
if nothing else needs it.

## Declare the secret in Nix

Add the secret name to `modules/aspects/_secrets/sops.nix`:

```nix
secrets = {
  "github_ssh_key" = {
    sopsFile = secretFiles.github;
  };
  "github_cli_token" = {
    sopsFile = secretFiles.github;
  };
  "kmeat_mac_mini_ssh_key" = {
    sopsFile = secretFiles.ssh;
  };
  "workstation_ssh_key" = {
    sopsFile = secretFiles.ssh;
  };
};
```

The `secrets` aspect reads `repo.user.secretFiles`. Its defaults are
`secrets/github.yaml` and `secrets/ssh.yaml`, as defined in
`modules/flake/options.nix`. Store GitHub credentials in `secretFiles.github`
and other SSH keys in `secretFiles.ssh`.

## Use the secret for SSH

Add the SOPS-managed secret path to the matching host entry in
`modules/aspects/_ssh/ssh.nix`:

```nix
"workstation-host" = {
  Hostname = "example.com";
  User = "example";
  IdentitiesOnly = true;
  IdentityFile = [config.sops.secrets."workstation_ssh_key".path];
};
```

## Verify

List the top-level secret names without printing their values:

```bash
for file in secrets/github.yaml secrets/ssh.yaml; do
  printf '%s:\n' "$file"
  sops -d "$file" | awk -F: '/^[A-Za-z0-9_]+:/ { print "  " $1 }'
done
```

Check that the encrypted files do not contain a plaintext private key:

```bash
rg -n "BEGIN OPENSSH PRIVATE KEY|END OPENSSH PRIVATE KEY" secrets/*.yaml
```

The command should print nothing.

Compare the SSH references with the declared SOPS secrets:

```bash
rg -o 'config\.sops\.secrets\."[^"]+"' \
  modules/aspects/_ssh/ssh.nix | sort -u
rg -o '"[A-Za-z0-9_]+" = \{' \
  modules/aspects/_secrets/sops.nix | sort -u
```

Evaluate the Darwin configuration:

```bash
nix build .#darwinConfigurations.fenrir.system \
  --dry-run \
  --accept-flake-config \
  --extra-experimental-features 'nix-command flakes'
```

Build and switch:

```bash
just switch fenrir
```

Test the SSH alias:

```bash
ssh -o BatchMode=yes workstation-host true
```

Successful authentication produces no output.
