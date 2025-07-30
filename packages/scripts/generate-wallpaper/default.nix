{pkgs, ...}:
pkgs.writeShellApplication {
  name = "generate-wallpaper";
  text = builtins.readFile ./generate-wallpaper;
}
