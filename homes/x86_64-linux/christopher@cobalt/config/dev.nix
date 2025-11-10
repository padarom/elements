{pkgs, ...}: {
  home.packages = with pkgs; [
    # Editors
    jetbrains-toolbox # Installer for JetBrains IDEs
    zed-editor
    code-cursor
    vscode

    # Language Servers
    lua-language-server
    rust-analyzer
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil # nix lsp

    zx # Tool for writing better scripts
    # trurl # Parsing and manipulating URLs via CLI
    dig # DNS
    onefetch # Git information tool
    tokei # Like cloc
    zeal # Offline documentation browser
    just # Just a command runner
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
