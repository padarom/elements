{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.beszel-agent;
in {
  options.services = {
    beszel-agent = {
      enable = mkEnableOption "Enable the Beszel Agent";
      key = mkOption {
        type = types.str;
        description = "The public key to bind the agent to";
      };
      port = mkOption {
        type = types.int;
        description = "The port to bind the agent to";
        default = 45876;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.beszel
      pkgs.rocmPackages.rocm-smi # Interface with AMD GPUs
    ];

    systemd.services.beszel-agent = {
      enable = true;
      description = "Beszel Agent (remote monitoring)";

      environment = {
        KEY = cfg.key;
        LISTEN = builtins.toString cfg.port;
      };

      serviceConfig = {
        ExecStart = "${pkgs.beszel}/bin/beszel-agent";
      };
    };
  };
}
