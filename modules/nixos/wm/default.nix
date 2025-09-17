{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.elements.wm;
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  hyprland-pkg = inputs.hyprland.packages.${pkgs.system}.hyprland;
  hyprland-portal-pkg = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  hyprland-session = "${hyprland-pkg}/share/wayland-sessions";
in {
  options.elements = {
    wm = {
      enable = mkEnableOption "Enable window manager configuration";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      xwayland-satellite
      hyprshot
    ];

    programs.hyprland = {
      enable = true;
      package = hyprland-pkg;
      portalPackage = hyprland-portal-pkg;
    };

    security = {
      polkit.enable = true;
      pam.services.swaylock = {};
    };

    xdg.portal = {
      config.common.default = ["hyprland"];
      config.hyprland.default = ["wlr" "gtk"];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --asterisks --time --remember --remember-session --sessions ${hyprland-session}";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
