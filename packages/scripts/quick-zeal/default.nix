{pkgs, ...}:
pkgs.writeShellApplication {
  name = "quick-zeal";
  text = builtins.readFile ./quick-zeal;
}
