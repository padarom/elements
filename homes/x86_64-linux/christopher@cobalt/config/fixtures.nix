{config, ...}: {
  home.file."${config.xdg.configHome}/eww" = {
    source = ../fixtures/eww;
    recursive = true;
  };
}
