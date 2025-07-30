{pkgs, ...}:
pkgs.mkShell {
  packages = with pkgs; [
    just
    cowsay
  ];

  # Define an alias to use a Justfile specifically with
  # deployment tooling enabled.
  shellHook = ''
    alias elements="just -f ${././Justfile} -d ${../..}"
  '';
}
