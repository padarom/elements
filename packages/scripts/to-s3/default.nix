{pkgs, ...}:
pkgs.writeShellApplication {
  name = "to-s3";
  text = builtins.readFile ./to-s3;
}
