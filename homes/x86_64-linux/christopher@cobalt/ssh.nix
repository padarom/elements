{
  config,
  lib,
  ...
}: let
  keys = [
    "config"
    "id_ethnuc"
    "id_europium"
    "id_github"
    "id_hausgold"
    "id_homeassistant"
    "id_rhenium"
  ];
in {
  elements.secrets.needs = builtins.listToAttrs (
    builtins.map
    (key:
      lib.attrsets.nameValuePair key {
        rekeyFile = "ssh/${key}.age";
        path = "${config.home.homeDirectory}/.ssh/${key}";

        symlink = false;
        mode = "0600";
      })
    keys
  );
}
