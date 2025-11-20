{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lxappearance
  ];

  gtk = {
    enable = true;

    iconTheme.name = "breeze-dark";
    cursorTheme = {
      name = "BreezeX-RosePineDawn-Linux";
      package = pkgs.rose-pine-cursor;
      size = 32;
    };

    gtk2.extraConfig = lib._elements.selfReferencedString {sep = "#";} ''
      gtk-enable-animations = 1
      gtk-primary-button-warps-slider = 1
      gtk-toolbar-style = 3
      gtk-menu-images = 1
      gtk-button-images = 1
      gtk-sound-theme-name = "freedesktop"
    '';

    font = {
      name = "Noto Sans";
      size = 10;
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
