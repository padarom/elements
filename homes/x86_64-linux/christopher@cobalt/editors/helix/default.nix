{pkgs, ...}: let
  catppuccin = pkgs.stdenv.mkDerivation {
    name = "catppuccin-helix-theme";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "helix";
      rev = "3b1b0b2446791812e4a76ba147223dd5f3d4319b";
      sha256 = "7TJ1CDts0i3QPRWz/gvRpkXzh8wGGLW5cv9+Vg3K1zc=";
    };
    installPhase = ''
      mkdir -p $out
      cp -r ./themes/* $out
    '';
  };
in {
  home.packages = [pkgs.helix];

  xdg.configFile."helix/themes/catppuccin".source = catppuccin;

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin";

      editor = {
        rulers = [80];
        shell = ["nu" "-c"];
        line-number = "relative";

        auto-format = true;
        file-picker.hidden = false;

        # TODO: Why does the clipboard not work?
        # clipboard-provider.custom = {
        #   yank = {command = "wl-copy";};
        #   paste = {command = "wl-paste";};
        # };

        whitespace.render = {
          tabpad = "all";
        };
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];

    themes = {
      catppuccin = {
        inherits = "catppuccin/default/catppuccin_frappe";
        "ui.background" = {};
        # "ui.virtual.whitespace" = {style = "dim";};
      };
    };
  };
}
