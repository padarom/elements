{pkgs, ...}:
pkgs.writeTextFile rec {
  name = "spawn-term";
  destination = "/bin/${name}";
  executable = true;

  text = ''
    #!/usr/bin/env nu

    let focused_window = (niri msg --json windows | from json | where { $in.is_focused == true } | first)

    if ($focused_window | get app_id) == "kitty" {
      let child_pid = (pgrep -P $"($focused_window | get pid)" | tail -1)
      if ($child_pid | is-empty) {
        kitty
        exit 0
      }

      let path = ($"/proc/($child_pid)/cwd" | path expand)
      kitty --directory $path
    } else {
      kitty
    }
  '';
}
