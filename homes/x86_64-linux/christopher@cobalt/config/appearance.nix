{pkgs, ...}: {
  home.packages = with pkgs; [
    rose-pine-cursor
    lxappearance
  ];

  gtk = {
    enable = true;

    cursorTheme = {
      name = "BreezeX-RoséPine";
      package = pkgs.rose-pine-cursor;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
    GTK_THEME = "rose-pine";
    XCURSOR_SIZE = "32";
  };
}
