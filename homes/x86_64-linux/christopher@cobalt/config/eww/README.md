In order to develop these widgets (with live reloading) do the following:

1. Kill the original eww daemon using `eww kill`
2. Start the new daemon using `eww open spraggins --config ~/.dotfiles/homes/x86_64-linux/christopher@cobalt/config/eww `
3. Now all changes to the original dotfiles defining the config will be hot-reloaded
