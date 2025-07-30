{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./core
    ./core/users.nix
    ./core/nix.nix

    ./programs/home-manager.nix
    ./programs/zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    pre-commit
    gitleaks
  ];
}
