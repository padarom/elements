{pkgs, ...}:
pkgs.writeShellApplication {
  name = "tofi-hg";
  text = builtins.readFile ./tofi-hg;
}
