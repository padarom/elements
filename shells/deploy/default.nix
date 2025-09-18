{
  lib,
  inputs,
  pkgs,
  ...
}:
pkgs.mkShell {
  packages = with pkgs; [
    just
    croc
    inputs.disko.packages.${pkgs.system}.disko
    helix
  ];

  # Define an alias to use a Justfile specifically with
  # deployment tooling enabled.
  shellHook = ''
    alias elements="just -f ${././Justfile}"
  '';
}
