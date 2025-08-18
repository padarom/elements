{
  pkgs,
  inputs,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  hyprland-pkg = inputs.hyprland.packages.${pkgs.system}.hyprland;
  hyprland-portal-pkg = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  hyprland-session = "${hyprland-pkg}/share/wayland-sessions";
in {
  environment.systemPackages = with pkgs; [
    swaynotificationcenter # Notification daemon for Wayland
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    hyprshot
  ];

  programs.hyprland = {
    enable = true;
    package = hyprland-pkg;
    portalPackage = hyprland-portal-pkg;
  };

  services.greetd = {
    enable = true;
    settings = rec {
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
}
