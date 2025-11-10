{channels, ...}: final: prev: {
  # Pull the following packages from unstable instead
  inherit (channels.unstable) kitty nu fish cider-2;
}
