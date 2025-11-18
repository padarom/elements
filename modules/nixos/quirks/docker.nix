{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (builtins.elem "docker" config.elements.quirks) {
    virtualisation.docker = {
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
}
