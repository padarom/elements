{
  config,
  inputs,
  lib,
  ...
}: {
  config = lib.mkIf (builtins.elem "avahi" config.elements.quirks) {
    # Use legacy docker compose v1
    environment.systemPackages = [
      inputs.docker-compose-1.legacyPackages."x86_64-linux".docker-compose
    ];

    virtualisation = {
      docker = {
        enable = true;

        # https://github.com/hausgold/knowledge/blob/master/troubleshooting/local-env-quirks.md#haproxy--docker-ulimit-glitch
        daemon.settings = {
          default-ulimits = {
            nofile = {
              Hard = 100000;
              Soft = 100000;
              Name = "nofile";
            };
          };
        };
      };
    };
  };
}
