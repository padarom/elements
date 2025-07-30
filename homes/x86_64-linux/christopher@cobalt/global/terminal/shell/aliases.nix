{lib, ...}: {
  home.shellAliases = {
    elements = "just -f ~/.dotfiles/Justfile -d ~/.dotfiles";
    elem = "elements";
    g = "git";
    copy = lib.mkDefault "xclip -sel clip";
    inspect = "tmux -f ~/.tmux.inspect.conf new-session ssh inspect";
    ansi = "sed -r \"s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\"";
    ssh = "TERM=xterm-color ssh";
    calc = "numbat --pretty-print never -e";
    pcalc = "numbat --pretty-print always -e";
    vim = "hx";
    vi = "hx";
  };
}
