{
  pkgs,
  config,
  ...
}: {
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
    atuin = {
      # Better (and synchronized) shell history
      enable = true;
      enableNushellIntegration = config.programs.nushell.enable;
      enableFishIntegration = config.programs.fish.enable;
    };

    zoxide = {
      # Quick-jump to folders
      enable = true;
      enableNushellIntegration = config.programs.nushell.enable;
      enableFishIntegration = config.programs.fish.enable;
    };

    carapace = {
      # Shell completions
      enable = true;
      enableNushellIntegration = config.programs.nushell.enable;
      enableFishIntegration = config.programs.fish.enable;
    };
  };
}
