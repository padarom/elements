{pkgs, ...}: let
  name = "open-url";
  bin = pkgs.writeShellApplication {
    inherit name;
    text = builtins.readFile ./open-url;
  };

  desktopItem = pkgs.makeDesktopItem {
    inherit name;
    desktopName = "Open URL in a Browser";
    exec = "${bin}/bin/${name}";
  };
in
  pkgs.symlinkJoin {
    inherit name;
    paths = [bin desktopItem];
  }
