{pkgs, ...}: {
  # Install common editors
  home.packages = with pkgs; [
    vscode
    zed-editor

    # Language Servers
    lua-language-server
    rust-analyzer
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil # nix lsp
  ];
}
