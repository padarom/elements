{
  pkgs,
  system,
  inputs,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "top-shell";
  name = pname;
  src = ./.;

  nativeBuildInputs = with pkgs; [
    wrapGAppsHook3
    gobject-introspection
    inputs.ags.packages.${system}.default
  ];

  buildInputs = [
    pkgs.glib
    pkgs.gjs
    #inputs.astal.io
    #inputs.astal.astal4
  ];

  installPhase = ''
    mkdir -p $out/bin
    ags bundle app.ts $out/bin/${pname}
  '';

  # preFixup = ''
  #   gappsWrapperArgs+=(
  #     --prefix PATH : ${pkgs.lib.makeBinPath [
  #     # runtime executables
  #   ]}
  #   )
  # '';
}
