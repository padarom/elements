set shell := ["nu", "-c"]
editor := env('EDITOR')

default:
  @just --list --justfile {{justfile()}}

# Runs `nixos-rebuild`
[group('nix')]
deploy:
  nixos-rebuild switch --flake . --use-remote-sudo

europium:
  nixos-rebuild switch --flake .#europium --target-host europium --build-host europium --use-remote-sudo

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
  nix develop .#{{name}}

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

# Exits the current user session
[group('desktop')]
[confirm]
logout:
  hyprctl dispatch exit
