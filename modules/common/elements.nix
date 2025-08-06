{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.elements;
in {
  options = {
    elements = {
      hostname = mkOption {type = types.str;};
    };
  };

  config = {
    networking.hostName = cfg.hostname;
  };
}
