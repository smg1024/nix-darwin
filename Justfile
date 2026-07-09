# just is a command runner, Justfile is very similar to Makefile, but simpler.

# List all the just commands
default:
    @just --list

############################################################################
#
#  Darwin related commands
#
############################################################################

[group('darwin')]
dry-run hostname:
    nix build .#darwinConfigurations.{{ hostname }}.system \
      --dry-run \
      --extra-experimental-features 'nix-command flakes'

[group('darwin')]
switch hostname:
    nh darwin switch . -H {{ hostname }}

[group('darwin')]
update hostname input='':
    @if [ -z "{{ input }}" ]; then \
      nh darwin switch . -H {{ hostname }} --update; \
    else \
      nh darwin switch . -H {{ hostname }} --update-input {{ input }}; \
    fi

[group('darwin')]
debug hostname:
    nh darwin switch . -H {{ hostname }} --show-trace -vv --print-build-logs --show-activation-logs

############################################################################
#
#  nix related commands
#
############################################################################

# Update all the flake inputs
[group('nix')]
up:
    nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
    nix flake update {{ input }}

# List all generations of the system profile
[group('nix')]
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
    nix repl -f flake:nixpkgs

# remove all generations older than 7 days and collect garbage
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
    sudo nh clean all --keep-since 7d --keep-one

[group('nix')]
fmt range:
    # format the nix files in this repo
    nix fmt {{ range }}

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
    ls -al /nix/var/nix/gcroots/auto/
