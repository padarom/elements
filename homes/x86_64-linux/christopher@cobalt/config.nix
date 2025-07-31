{lib, ...}:
with builtins;
  map
  (name: ./config + "/${name}")
  (filter (lib.strings.hasSuffix ".nix") (attrNames (readDir ./config)))
