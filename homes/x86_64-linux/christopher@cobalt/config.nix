{lib, ...}:
with builtins; let
  # Determines whether the given file name ends with ".nix"
  endsWithNix = fileName: substring (lib.trivial.max 0 (stringLength fileName - 4)) 4 fileName == ".nix";
in
  map (name: ./config + "/${name}") (filter endsWithNix (attrNames (readDir ./config)))
