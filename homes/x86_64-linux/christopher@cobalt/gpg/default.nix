{pkgs, ...}: {
  # TODO: Is this needed if `services.gpg-agent.pinentryPackage` is specified?
  home.packages = [pkgs.pinentry-qt];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  # home.file.".gnupg/gpg-agent.conf".text = ''
  #   pinentry-program /run/current-system/sw/bin/pinentry
  # '';
}
