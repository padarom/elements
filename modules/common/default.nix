{pkgs, ...}: {
  # This module is common to all systems, both nixos and darwin. It is
  # automatically added to all hosts via the flake configuration.

  imports = [
    ./elements.nix
    ./secrets.nix
    ./nix.nix

    ./programs/home-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    pre-commit
    git
    gitleaks
    just
    nh
    age
  ];
}
