{config, ...}: let
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./programs
    ./shell/aliases.nix
    ./shell/prompt.nix
    ./shell/fish.nix
    ./shell/nu.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = "${cache}/less/history";
    LESSKEY = "${conf}/less/lesskey";

    BROWSER = "firefox";
    TERMINAL = "kitty";
    EDITOR = "hx";
    TERM = "xterm-color";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
