{...}: {
  programs.kitty = {
    enable = true;

    settings = {
      window_padding_width = "5 10";
      font_family = "Monaspace Krypton";
      paste_actions = "no-op";
    };

    extraConfig = ''
      modify_font cell_height 7px
    '';

    themeFile = "Catppuccin-Frappe";
  };
}
