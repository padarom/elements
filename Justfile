set shell := ["bash", "-c"]
editor := env('EDITOR')

default:
  @just --list --justfile {{justfile()}}

# TODO: Run `pre-commit install` at some point

# Runs `nixos-rebuild` or `darwin-rebuild` depending on the OS
[group('nix')]
deploy:
  {{if os() == "linux" { \
      "nixos-rebuild switch --flake . --sudo" \
    } else { \
      "sudo darwin-rebuild switch --flake ." \
    } \
  }}

europium:
  nixos-rebuild switch --flake .#europium --target-host europium-deploy --build-host europium --use-remote-sudo

beryllium:
  nixos-rebuild switch --flake .#beryllium --target-host beryllium-deploy --build-host beryllium --use-remote-sudo
  
# Opens the elements configuration in the default editor
edit:
  {{editor}} {{shell('pwd')}}

# Runs nix-output-monitor in debug mode
[group('nix')]
debug:
  nom build ".#nixosConfigurations.{{shell('hostname')}}.config.system.build.toplevel" --show-trace --verbose

[group('nix')]
repl:
  nix repl --expr "builtins.getFlake \"{{shell('pwd')}}\""

# Enter a flake dev shell
[group('nix')]
shell name:
  nix develop --extra-experimental-features "flakes nix-command" .#{{name}}

# Updates nix flakes
[group('nix')]
up:
  nix flake update

# Updates a specific flake input
[group('nix')]
upp input:
  nix flake update {{input}}

# Collects old garbage
[group('nix')]
gc:
  sudo nix-collect-garbage --delete-old

# Rekey all secrets where needed
[group('secrets')]
rekey:
  agenix rekey -a

# Edit a single secret file
[group('secrets')]
[positional-arguments]
edit-secret file:
  agenix edit {{file}}

# Exits the current user session
[group('desktop')]
[confirm]
logout:
  hyprctl dispatch exit
