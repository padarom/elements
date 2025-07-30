{pkgs, ...}: {
  home.packages = with pkgs; [
    # Dev tools
    direnv
    silver-searcher # ag search tool
    zx # Tool for writing better scripts
    trurl # Parsing and manipulating URLs via CLI
    onefetch # Git information tool
    cloc # Line-of-code calc for entire project
    tokei # Like cloc
    delta # Diffing tool
    zeal # Offline documentation browser
    just # Just a command runner

    # Build tools
    cargo
    glibc
    gcc

    claude-code

    php82
    php82Packages.composer

    bun
    nodejs_20
    nodejs_20.pkgs.pnpm
  ];

  # `nix-shell` replacement for project development
  # Most useful with `pkgs.direnv`
  services.lorri.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.go.enable = true;

  programs.neovim = {
    enable = false;
    # defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # extraConfig = lib.fileContents ../fixtures/neovim/init.vim;

    #plugins = with pkgs.vimPlugins; [
    #  nvim-treesitter.withAllGrammars
    #];
  };
}
