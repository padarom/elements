{pkgs, ...}:
pkgs.writeShellApplication {
  name = "connect-to-mercury";
  text = builtins.readFile ./connect-to-mercury;
}
