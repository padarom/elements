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

## How to deploy a new host

Boot into an [install medium](https://nixos.org/download/). Since this repository is
public, we don't need to mess with any SSH keys yet. Clone the repository and enter it.
```
  git clone https://github.com/padarom/elements.git
  cd elements
```

Then install `just`, which is the only explicit requirement for this deployment which
you must install manually. All other dependencies are automatically installed in the dev shell.

After installing just, enter the deployment shell.
```
  nix-shell -p just
  just shell deploy
```

Now, a basic host configuration (with a disko module) is required. This can either
be prepared on another host and comitted, or created now, in the install medium.
Depending on how many hosts I will still onboard, I might end up creating helper
functionality in the dev shell specifically for this use case.

Now, say the host we want to deploy is configured as `hydrogen`. Inspect the
compiled disko disk configuration for the host:
```
  elements disk-test hydrogen
```

If that configuration seems fine, you can deploy it. This will wipe and reformat
the configured drives. Disko will ask you whether you want to confirm.
```
  elements disk hydrogen
```

Your disk is now ready and you can install NixOS onto the disk. Run the following:
```
  elements install hydrogen
```

Now NixOS is ready and can be booted. You can decide whether you also want to
copy the elements config into a user's home directory. Alternatively, the host can
simply be remote-managed via another host, so this step isn't always necessary.
```
  elements config hydrogen {username}
```

Ideally in the future we'll be able to set an encrypted password file and deploy
the host with that. Since the host does not yet have a SSH key to decrypt any
(rekeyed) secrets that might already be present, that is not yet possible. Therefore
the following is still required:
```
  # Exit from all dev shells to get back to your original shell

  sudo nixos-enter
  passwd {username}
```

### Todo
Since this is pretty much always a work-in-progress I do not expect it to be in the
most presentable state at all times. Whenever I have time I try to streamline some of
the config, but especially when trying out new tools the code could be a bit wild.

There's a couple of ideas I have for this:
- [ ] Deploy base tooling to all hosts. This mainly includes `nushell` and `helix` configs. They should still be configurable per-host. Potential issue here could be hosts where I don't use home manager
- [ ] Make everything more composable. Can make use of the `elements` config some more, like how it's done for `quirks`

[just]: https://github.com/casey/just
[snowfall]: https://snowfall.org/guides/lib/quickstart
