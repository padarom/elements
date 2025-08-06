{...}: {
  imports = [
    ./helix
    ./terminal
  ];

  home = {
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
