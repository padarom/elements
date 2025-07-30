{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.monaspace # Patched fonts
    google-fonts # Google fonts
    monaspace
  ];

  fonts.fontconfig.enable = true;

  home.file.".local/share/fonts" = {
    # This includes FontAwesome and other proprietary fonts which are licensed,
    # so I have to download them from a private repository
    source = builtins.fetchGit {
      url = "git@github.com:padarom/fonts.git";
      rev = "2defdedf6642865648c8e57b3851a77ac0ae2d7b";
    };
    recursive = true;
  };
}
