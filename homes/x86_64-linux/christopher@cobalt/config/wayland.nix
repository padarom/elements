{
  pkgs,
  inputs,
  ...
}: let
  inputPkg = inputName: pluginName: inputs.${inputName}.packages.${pkgs.system}.${pluginName};
in {
  home.packages = with pkgs; [
    wl-clipboard
    cliphist # Wayland clipboard
    hyprpicker # Color picker
    hyprpaper # Wallpaper utility
  ];

  services.hyprpaper = {
    enable = true;
    settings.splash = false;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # systemd.variables = ["--all"];
    package = inputPkg "hyprland" "hyprland";

    plugins = [
      (inputPkg "split-monitor-workspaces" "split-monitor-workspaces")
      # (inputPkg "hypridle" "hypridle")
    ];

    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors
      monitor=desc:Samsung Electric Company C49HG9x HTRJ901269,      3840x1080, 0x0, 1 # Left
      monitor=desc:Ancor Communications Inc ASUS VE278 C5LMTF047320, 1920x1080, 3840x-550, 1, transform, 1 # Right

      # Any other random monitor
      monitor=,preferred,auto,1

      # Gaps for eww
      monitor=DP-1,addreserved,40,0,0,0
      # monitor=,addreserved,40,0,0,0

      # Single tiled windows in a workspace on my main monitor
      # should be displayed with a padding on both sides
      workspace=w[t1] m[0],gapsout:15 840 15 840

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      exec-once = ibus-daemon -drxR
      exec-once = hyprpaper & # Wallpaper util
      exec-once = swaync & # Notification center
      exec-once = udiskie # Automatic mounting of USBs
      exec-once = sleep 2; ${pkgs._elements.generate-wallpaper}/bin/generate-wallpaper
      # exec-once = eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &
      exec-once = eww daemon
      exec-once = eww open spraggins
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,28
      env = HYPRCURSOR_THEME,rose-pine-hyprcursor
      env = HYPRCURSOR_SIZE,28
      env = WLR_NO_HARDWARE_CURSORS,1
      env = NIXOS_OZONE_WL,1

      debug {
        disable_logs = false
      }

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
        kb_layout = us
        kb_variant = intl
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 2

        touchpad {
          natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 8
        gaps_out = 15
        border_size = 3
        col.active_border = rgba(bf616aee) rgba(ebcb8bee) 45deg
        col.inactive_border = rgba(5e81acaa)

        layout = dwindle
      }

      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 2
        blur {
          enabled = true
          xray = true
          size = 4
          noise = 0.3
          passes = 2
        }

        shadow {
          enabled = true
          range = 4
          render_power = 3
          color = 0xee1a1a1a
        }
      }

      animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      plugin {
        split-monitor-workspaces {
          count = 10
        }
      }

      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
      }

      master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true
        slave_count_for_center_master = 2
        orientation = center
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
      }

      windowrule = float, class:(.*zeal.*)
      windowrule = center 1, class:(.*zeal.*)
      windowrule = size 50% 80%, class:(.*zeal.*)
      windowrule = minsize 1400 500, class:(.*zeal.*)

      windowrule = float, class:(.*speedcrunch.*)
      windowrule = center 1, class:(.*speedcrunch.*)
      windowrule = size 30% 60%, class:(.*speedcrunch.*)

      windowrule = float, title:DevTools

      windowrule=nofocus,class:^jetbrains-(?!toolbox),floating:1,title:^win\d+$

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, C, exec, ${pkgs._elements.spawn-term}/bin/spawn-term
      bind = $mainMod, W, killactive,
      # bind = $mainMod, M, exit,
      bind = $mainMod, M, fullscreen, 1
      bind = $mainMod, E, exec, thunar
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, G, exec, ${pkgs._elements.tofi-hg}/bin/tofi-hg
      bind = $mainMod, D, exec, ${pkgs._elements.quick-zeal}/bin/quick-zeal
      bind = $mainMod, space, exec, tofi-drun | xargs hyprctl dispatch exec --
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, split-workspace, 1
      bind = $mainMod, 2, split-workspace, 2
      bind = $mainMod, 3, split-workspace, 3
      bind = $mainMod, 4, split-workspace, 4
      bind = $mainMod, 5, split-workspace, 5
      bind = $mainMod, 6, split-workspace, 6
      bind = $mainMod, 7, split-workspace, 7
      bind = $mainMod, 8, split-workspace, 8
      bind = $mainMod, 9, split-workspace, 9

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, split-movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, split-movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, split-movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, split-movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, split-movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, split-movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, split-movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, split-movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, split-movetoworkspacesilent, 9

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}
