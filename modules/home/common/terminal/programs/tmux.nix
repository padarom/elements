{
  lib,
  pkgs,
  ...
}: let
  tmuxConfigFile = ".tmux.inspect.conf";
in {
  home.packages = [pkgs.tmux];

  home.shellAliases.inspect = "tmux -f ~/${tmuxConfigFile} new-session ssh inspect";

  home.file.${tmuxConfigFile}.text = lib._elements.selfReferencedString {sep = "#";} ''
    set -g status-position top
    set-option -g status-bg default
    set -g 'status-format[0]' '#[fill=colour202 bg=colour202 fg=colour231 bold]Danger! HAUSGOLD Inspector '
    set-option -g status-justify centre
    #set -g 'status-format[1]' '#[bg=default]'
    #set -g status 2

    #set -g status-left '''
    #set -g window-status-current-format '''
    #set -g window-status-format '''
  '';
}
