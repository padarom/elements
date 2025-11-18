{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.elements;
in {
  options = {
    elements.kitty = {
      enable = mkEnableOption "kitty";
    };
  };

  config = mkIf cfg.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
        window_padding_width = "5 10";
        font_family = "Monaspace Krypton";
        paste_actions = "no-op";
      };

      actionAliases = {
        "launch_current" = "launch --cwd current";
      };

      extraConfig = ''
        shell ${pkgs.nushell}/bin/nu
        modify_font cell_height 7px
      '';

      themeFile = "Catppuccin-Frappe";
    };

    xdg.configFile."kitty/open-actions.conf".text = ''
      # Open all file links in helix in the current shell
      protocol file
      # mime text/*
      action send_text normal,application hx "''${FILE_PATH}"\r
    '';
  };
}
