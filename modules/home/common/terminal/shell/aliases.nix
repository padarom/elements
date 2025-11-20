{lib, ...}: {
  home.shellAliases = {
    elements = "just -f /nix/elements/Justfile -d /nix/elements";
    copy = lib.mkDefault "wl-copy";
    ansi = "sed -r \"s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\"";
    calc = "numbat --pretty-print never -e";
    pcalc = "numbat --pretty-print always -e";
    cat = "bat";
    vim = "hx";
    vi = "hx";
  };
}
