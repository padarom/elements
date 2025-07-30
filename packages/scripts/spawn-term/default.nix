{pkgs, ...}:
pkgs.writeShellApplication {
  name = "spawn-term";
  text = builtins.readFile ./spawn-term;
}
