{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [neovim ripgrep];

  xdg.configFile.nvim.source = ./config;

  # Install the packer.nvim plugin manager
  home.file = {
    ".local/state/nix/profile/share/nvim/site/pack/packer/start/packer.nvim".source = pkgs.fetchFromGitHub {
      owner = "wbthomason";
      repo = "packer.nvim";
      rev = "ea0cc3c";
      sha256 = "fLM+ptjMd1YNoJQEI0vvr4sjaay7dfpaGhvWUy91d1M=";
    };
  };
}
