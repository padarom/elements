{
  lib,
  pkgs,
  ...
}:
lib._elements.writeNushellApplication pkgs {
  name = "spawn-term";
  runtimeInputs = with pkgs; [kdotool];

  text = ''
    let focused_window = (kdotool getactivewindow)

    if (kdotool getwindowclassname $focused_window) == "kitty" {
      let kitty_pid = (kdotool getwindowpid $focused_window | into int)
      if ($kitty_pid | is-empty) {
        kitty
        exit 0
      }

      let shell_pid = (ps | where ppid == $kitty_pid | where name != "kitten" | get pid | first)
      if ($shell_pid | is-empty) {
        kitty
        exit 0
      }

      let path = ($"/proc/($shell_pid)/cwd" | path expand)
      kitty --directory $path
    } else {
      kitty
    }
  '';
}
