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

    awww img -o DP-3 $landscape --transition-type wipe --transition-angle 30 --transition-step 90
    awww img -o DP-1 $portrait --transition-type wipe --transition-angle 75 --transition-step 90
  '';
}
