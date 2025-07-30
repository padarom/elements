{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.elements.secrets;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
  ];

  options = {
    elements.secrets = {
      rekeyPath = mkOption {
        type = types.str;
      };

      key = mkOption {
        type = types.str;
      };

      needs = mkOption {
        type = types.attrsOf (types.either types.str types.attrs);
        default = {};
      };
    };
  };

  config.age =
    (lib._elements.agenixRekeyConfig inputs.self cfg)
    // {
      identityPaths = ["${config.home.homeDirectory}/.ssh/key"];
      secretsDir = "${config.home.homeDirectory}/.local/share/agenix/agenix";
      secretsMountPoint = "${config.home.homeDirectory}/.local/share/agenix/agenix.d";
    };
}
