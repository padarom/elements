{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.elements.wm;
in {
  options.elements = {
    wm = {
      enable = mkEnableOption "Enable window manager configuration";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.discover
      kdePackages.kclock
      kdePackages.kcharselect
      kdePackages.kolourpaint
      kdePackages.ksystemlog
      wayland-utils
      wl-clipboard
      libsForQt5.qtstyleplugin-kvantum
      # xwayland-satellite
    ];

    services.xserver = {
      enable = true;

      # SDDM is broken
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";
    # services.displayManager.sddm.enable = true;
    # services.displayManager.sddm.wayland.enable = true;
    # services.displayManager.sddm.wayland.compositor = "kwin";

    # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    security = {
      polkit.enable = true;
      pam.services.swaylock = {};
    };
  };
}
