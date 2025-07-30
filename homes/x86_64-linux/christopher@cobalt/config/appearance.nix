{pkgs, ...}: {
  home.packages = with pkgs; [
    lxappearance
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "oomox-rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

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
