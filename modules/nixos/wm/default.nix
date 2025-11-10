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
      # xwayland-satellite
    ];

    programs.niri.enable = true;

    # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    services = {
      # niri-session-manager = {
      #   enable = true;
      #   settings = {
      #     save-interval = 15;
      #     max-backup-count = 3;
      #   };
      # };

      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --asterisks --time --remember --remember-session";
            user = "greeter";
          };
        };
      };
    };

    security = {
      polkit.enable = true;
      pam.services.swaylock = {};
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
