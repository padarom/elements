{pkgs, ...}: {
  # Install common editors
  home.packages = with pkgs; [
    zed-editor

    # Language Servers
    lua-language-server
    rust-analyzer
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil # nix lsp
  ];
}
