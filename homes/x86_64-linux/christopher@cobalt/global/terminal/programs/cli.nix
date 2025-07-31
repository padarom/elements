{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shell software
    fzf # Fuzzy finding
    bat # cat alternative
    yazi # Terminal file manager
    zellij # terminal workspace
    silver-searcher # ag search tool
    gum

    httpie # HTTP client / CURL alternative

    genact # Jibberish output ("I'm waiting for a compile.")
    cbonsai # Create bonsai trees
  ];

  programs = {
    atuin.enable = true; # Better shell history
    atuin.enableNushellIntegration = true;
  };
}
