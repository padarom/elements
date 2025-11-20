{
  lib,
  pkgs,
  config,
  ...
}: let
  env =
    lib.concatMapAttrsStringSep
    "\n"
    (name: value: "set -gx ${name} ${lib.escapeShellArg value}")
    config.home.sessionVariables;
in {
  programs.fish = {
    enable = true;

    shellAliases = config.home.shellAliases;
    shellInit = lib._elements.selfReferencedString {sep = "#";} ''
      # Set global environment variables.
      ${env}
    '';

    functions = {
      agx = {
        wraps = "ag";
        description = "Runs ag on the given string and returns a list of selectable references of the result. The selection is then opened in the editor.";
        body = ''
          hx (ag $search $argv[2..] | fzf | cut -d : -f 1,2)
        '';
      };
    };

    preferAbbrs = true;
    shellAbbrs = {
      elm = "elements";
    };
  };
}
