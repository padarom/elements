{lib, ...}: {
  # All quirks are imported and check themselves whether they are enabled
  # via `(builtins.elem "quirk" config.elements.quirks)`.
  imports = [
    ./avahi.nix
    ./docker.nix
    ./nix-ld.nix
  ];

  options.elements = with lib; {
    quirks = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
}
