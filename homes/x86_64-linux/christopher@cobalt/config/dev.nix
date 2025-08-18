{pkgs, ...}: {
  home.packages = with pkgs; [
    zx # Tool for writing better scripts
    trurl # Parsing and manipulating URLs via CLI
    onefetch # Git information tool
    tokei # Like cloc
    zeal # Offline documentation browser
    just # Just a command runner
    jetbrains-toolbox # Installer for JetBrains IDEs
    claude-code
    devenv

    # Build tools
    cargo
    glibc
    gcc

    php82
    php82Packages.composer

    bun
    nodejs_20
    nodejs_20.pkgs.pnpm
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.go.enable = true;
}
