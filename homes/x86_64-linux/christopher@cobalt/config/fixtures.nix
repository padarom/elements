{config, ...}: {
  # SSH keys and settings
  # Don't copy SSH settings as they would not be readable by Docker containers
  # that require them.
  # home.file.".ssh" = {
  #   source = ../fixtures/ssh;
  #   recursive = true;
  # };

  home.file."${config.xdg.configHome}/eww" = {
    source = ../fixtures/eww;
    recursive = true;
  };
}
