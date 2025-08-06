# ++ 42_Mo: Molybdenum
#
# MacBook Pro work environment
{self, ...}: {
  system.stateVersion = 5;

  elements = {
    hostname = "molybdenum";
    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjqieS4GkYAa1WRYZpxjgYsj7VGZ9U+rTFCkX8M0umD";
    };
  };

  # For some reason this is required for hm to work with nix-darwin
  users.users.christopher = {};
}
