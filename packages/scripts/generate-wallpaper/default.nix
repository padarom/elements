{
  pkgs,
  stdenv,
  ...
}:
with pkgs; let
  themes = stdenv.mkDerivation {
    name = "catppuccin-base16-json";

    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "base16";
      rev = "99aa911b29c9c7972f7e1d868b6242507efd508c";
      hash = "sha256-HHodDRrlcBVWGE3MN0i6UvUn30zY/JFEbgeUpnZG5C0=";
    };

    buildInputs = [yq];

    # Take all yaml files and convert them to json.
    installPhase = ''
      mkdir -p $out
      ls $src/base16 | sed 's/\.yaml$//' | xargs -I {} sh -c "yq '.' $src/base16/{}.yaml > $out/{}.json"
    '';
  };
in
  writeShellApplication {
    name = "generate-wallpaper";

    runtimeInputs = [
      imagemagick
      nodejs_24
      jq
    ];

    text = ''
      # TODO: Do we want this configurable via an argument?
      THEME="macchiato"

      THEME_JSON_PATH="${themes}/$THEME.json"
      SCHEME_NAME=$(jq -r '.scheme' "$THEME_JSON_PATH")
      SCHEME_NAME_LWR=$(echo "$SCHEME_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

      WALLPAPER_ROOT="/tmp/wallpaper"
      WALLPAPER_FILE="$WALLPAPER_ROOT/$SCHEME_NAME/Circuits wallpaper/themer-$SCHEME_NAME_LWR-dark"
      WALLPAPER_DIR=$(dirname "$WALLPAPER_FILE")

      npx themer -t wallpaper-circuits -o "$WALLPAPER_ROOT" --color-set "$THEME_JSON_PATH" -s 3840x1080 -s 1080x1920
      find "$WALLPAPER_DIR" -type f -iname '*.svg' | sed 'p;s/\.svg/\.png/' | sed 's/.*/"&"/' | xargs -n2 magick

      hyprctl hyprpaper reload DP-3,"$WALLPAPER_FILE-3840x1080.png"
      hyprctl hyprpaper reload DP-1,"$WALLPAPER_FILE-1080x1920.png"
    '';
  }
