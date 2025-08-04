{
  pkgs,
  config,
  ...
} @ all: {
  imports =
    [
      ./ssh.nix
      ./gpg
      ./misc/launcher.nix
      ./misc/browser.nix
      ./misc/gaming.nix
      ./misc/onedrive.nix
      ./misc/everything.nix # TODO: Determine if we really always want all these programs or they should be composable
      ./global/terminal
      ./global/current-packages.nix
      ./editors/helix
      ./editors/jetbrains
    ]
    ++ (import ./config.nix all);

  elements.secrets = {
    rekeyPath = "christopher_cobalt";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl33DPxxzxrNNjM8rL4ktAj4ExzCyGiU8rKog0csxNA";

    needs = {
      repoUpdatePAT = "repo-update-pat.age";
      npmrc = {
        rekeyFile = "npmrc.age";
        path = "${config.home.homeDirectory}/.npmrc";
      };
    };
  };

  home = {
    extraOutputsToInstall = ["doc" "devdoc"];

    # Until Home Manager 24.11 releases
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs._elements; [
      quick-zeal
      spawn-term
      to-s3
      tofi-hg
      open-url
      generate-wallpaper
    ];
  };

  programs.home-manager.enable = true;

  # home.file.".config/Yubico/u2f_keys".text = "christopher:C7akk/T8XYov6fOk3rGo0ZW66QPMtdLnGznPuK+tTh/qmPecvECzGVMKJuh5M7nYsMoT6r/idAP88FGinf/rpw==,ydS/PgUALZriaaHYS81u3x8rRFulq727GDJRlvbJhP2yeKK7Ih+xqRceyabLR3MxRN8PT/MtC1I/Xjaxl0S2Rg==,es256,+presence";
}
