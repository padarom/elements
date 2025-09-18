{
  pkgs,
  config,
  ...
}: {
  elements.secrets = {
    rekeyPath = "christopher_beryllium";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUKDCjB0VpQubi8BfnYKbh4MIE1tcvKQesdoPE4NXAf";

    needs = {
      traefik-env = "traefik.env.age";
    };
  };

  # virtualisation.quadlet.containers = {
  #   echo = {
  #     autoStart = true;
  #     serviceConfig = {
  #       RestartSec = "10";
  #       Restart = "always";
  #     };
  #     containerConfig = {
  #       image = "docker.io/mendhak/http-https-echo:31";
  #       publishPorts = ["127.0.0.1:8080:8080"];
  #     };
  #   };
  # };

  home.packages = with pkgs; [
    helix
  ];
}
