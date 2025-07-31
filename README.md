## My NixOS systems
This repository contains all my NixOS (and nix-darwin) system and home manager configurations.
It's not meant to be deployable by anyone other than me, but just as a reference for others.

## General principles
I'm using [Snowfall][snowfall] in order to organize my flake in an easy way that doesn't
require too much boilerplate code.

Every wheels user will have a command available called `elements` with which they
are able to interface with this main Nix flake. Internally this command is an alias
for the [just command runner][just] which automatically links to the flake's Justfile.

Additionally, every dev shell can also expand on the available `elements` recipes
depending on the context. In order to enter one of the configured devshells, one
can use either the command `elements shell <name>` (if elements is already
available) or run `nix develop .#name` in the flake root directory.

### Todo
Since this is pretty much always a work-in-progress I do not expect it to be in the
most presentable state at all times. Whenever I have time I try to streamline some of
the config, but especially when trying out new tools the code could be a bit wild.

There's a couple of ideas I have for this:
- [ ] Build a deployment dev shell
- [ ] Deploy base tooling to all hosts. This mainly includes `nushell` and `helix` configs. They should still be configurable per-host. Potential issue here could be hosts where I don't use home manager
- [ ] Make everything more composable. Can make use of the `elements` config some more, like how it's done for `quirks`

[just]: https://github.com/casey/just
[snowfall]: https://snowfall.org/guides/lib/quickstart
