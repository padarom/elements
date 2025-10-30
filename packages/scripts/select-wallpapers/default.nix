{pkgs, ...}:
pkgs.writeTextFile rec {
  name = "select-wallpapers";
  destination = "/bin/${name}";
  executable = true;

  text = ''
    #!/usr/bin/env nu

    let wallpaper_dir = "/home/christopher/Wallpapers"

    let landscape = (ls $"($wallpaper_dir)/Landscape" | shuffle | get name | first)
    let portrait  = (ls $"($wallpaper_dir)/Portrait" | shuffle | get name | first)

    hyprctl hyprpaper reload $"DP-3,($landscape)"
    hyprctl hyprpaper reload $"DP-1,($portrait)"
  '';
}
