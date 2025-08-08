{config, ...}: let
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./programs
    ./shell/aliases.nix
    ./shell/prompt.nix
    # ./shell/nu
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = "${cache}/less/history";
    LESSKEY = "${conf}/less/lesskey";
    DIRENV_LOG_FORMAT = "";

    # BROWSER = "firefox";
    BROWSER = "vivaldi";
    TERMINAL = "kitty";
    EDITOR = "hx";
    TERM = "xterm-color";

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
