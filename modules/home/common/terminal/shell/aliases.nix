{lib, ...}: {
  home.shellAliases = {
    elements = "just -f ~/.dotfiles/Justfile -d ~/.dotfiles";
    elem = "elements";
    g = "git";
    copy = lib.mkDefault "wl-copy";
    inspect = "tmux -f ~/.tmux.inspect.conf new-session ssh inspect";
    ansi = "sed -r \"s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\"";
    calc = "numbat --pretty-print never -e";
    pcalc = "numbat --pretty-print always -e";
    cat = "bat";
    vim = "hx";
    vi = "hx";
  };
}
