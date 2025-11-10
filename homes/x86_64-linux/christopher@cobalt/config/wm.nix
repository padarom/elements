{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    rose-pine-cursor
    xwayland-satellite
    inputs.awww.packages.${pkgs.system}.awww
    _elements.select-wallpapers
    _elements.ags
  ];

  services.swayidle.enable = true;

  programs = {
    niri.settings = {
      input.keyboard.xkb = {
        layout = "us";
        variant = "intl";
      };

      outputs = {
        "DP-3".position = {
          x = 0;
          y = 0;
        };

        "DP-1".transform.rotation = 90;
        "DP-1".position = {
          x = 3840;
          y = -450;
        };
      };

      environment = {
        GDK_BACKEND = "wayland";
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      spawn-at-startup = [
        {command = ["xwayland-satellite"];}
        {command = ["awww-daemon"];}
        {command = ["keymapp"];}
        {command = ["select-wallpapers"];}
      ];

      cursor.theme = "BreezeX-RosePineDawn-Linux";
      cursor.size = 32;

      layout = {
        always-center-single-column = true;
        background-color = "transparent";
      };

      window-rules = [
        {
          geometry-corner-radius = let
            r = 4.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
        {
          matches = [{app-id = "org.zealdocs.zeal";}];
          open-floating = true;
        }
        {
          matches = [{title = "slack";}];
          open-on-output = "DP-1";
        }
      ];

      layer-rules = [
        {
          matches = [{namespace = "^awww-daemon$";}];
          place-within-backdrop = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Space".action = spawn "fuzzel";
        "Mod+W".action = close-window;

        "Mod+C".action = spawn "${pkgs._elements.spawn-term}/bin/spawn-term";
        "Mod+D".action = spawn "${pkgs._elements.quick-zeal}/bin/quick-zeal";
        "Mod+G".action = spawn "${pkgs._elements.tofi-hg}/bin/tofi-hg";

        # Movement bindings, both for mouse and kbd-only usage
        "Mod+k".action = focus-workspace-up;
        "Mod+j".action = focus-workspace-down;
        "Mod+h".action = focus-column-left;
        "Mod+l".action = focus-column-right;
        "Mod+Shift+k".action = move-window-to-workspace-up;
        "Mod+Shift+j".action = move-window-to-workspace-down;
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+WheelScrollRight".action = focus-column-right;
      };
    };
  };
}
