{pkgs, ...}: let
  name = "open-url";
  bin = pkgs.writeShellApplication {
    inherit name;
    text = builtins.readFile ./open-url;
  };

  desktopItem = pkgs.makeDesktopItem {
    inherit name;
    desktopName = "Open URL in a Browser";
    comment = "Open the given URL in a browser-profile based on context";
    mimeTypes = ["x-scheme-handler/http" "x-scheme-handler/https"];
    exec = "${bin}/bin/${name} %u";
  };
in
  pkgs.symlinkJoin {
    inherit name;
    paths = [bin desktopItem];
  }
