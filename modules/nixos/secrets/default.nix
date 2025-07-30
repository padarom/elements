# All hosts automatically include this module. This also means that it is necessary for
# every host to specify the option `elements.secrets.key = "key";`.
{
  config,
  system,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.elements.secrets;
in {
  options = {
    elements.secrets = {
      rekeyPath = mkOption {
        type = types.str;
        default = config.elements.hostname;
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

  config = {
    environment.systemPackages = [
      pkgs.age-plugin-yubikey
      inputs.agenix-rekey.packages.${system}.default
    ];

    age = lib._elements.agenixRekeyConfig inputs.self cfg;
  };
}
