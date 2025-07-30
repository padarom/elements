{
  pkgs,
  config,
  ...
}: let
  # We install these with JetBrains toolbox for convenience' sake, but we still want them
  # available in our PATH, so they are defined here.
  jetbrainsIDEs = ["phpstorm" "rubymine" "rustrover" "webstorm"];
in {
  home.packages = with pkgs; [
    jetbrains-toolbox
  ];

  home.sessionPath = map (ide: "${config.home.homeDirectory}/.local/share/JetBrains/Toolbox/apps/${ide}/bin") jetbrainsIDEs;
}
