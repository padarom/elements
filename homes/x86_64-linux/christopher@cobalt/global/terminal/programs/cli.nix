{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # Shell software
    fzf # Fuzzy finding
    eza # ls alternative
    httpie # HTTP client / CURL alternative
    yazi # Terminal file manager

    # Little thingies
    gum

    gh
    gitAndTools.git-absorb
    direnv

    zellij # terminal workspace
    silver-searcher # ag search tool
    zx # Tool for writing better scripts
    trurl # Parsing and manipulating URLs via CLI
    onefetch # Git information tool
    cloc # Line-of-code calc for entire project
    delta # Diffing tool

    genact # Jibberish output ("I'm waiting for a compile.")
    cbonsai # Create bonsai trees
    wtfutil
  ];

  programs = {
    atuin.enable = true; # Better shell history
    atuin.enableNushellIntegration = true;
  };
}
