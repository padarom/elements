{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tofi
    fuzzel
  ];

  # Clear the tofi cache after each activation so that newly installed packages
  # are immediately available using tofi-drun.
  home.activation.cleanTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
    rm -rf ~/.cache/tofi-drun
  '';
}
