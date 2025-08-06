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

      extraConfig = ''
        shell ${pkgs.nushell}/bin/nu
        modify_font cell_height 7px
      '';

      themeFile = "Catppuccin-Frappe";
    };
  };
}
