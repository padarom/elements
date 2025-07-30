# ++ 63_Eu: Europium
#
# Hosted VPS used primarily as an email server
{pkgs, ...}: {
  imports = [./hardware.nix];

  system.stateVersion = "23.11";

  elements = {
    hostname = "europium";
    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzw6hzrX3zDJAiMfhVpU+t1xr9C2PxJ9rf4HUfRzTiU";

      needs = {
        compose = {
          rekeyFile = "stalwart-compose.yaml.age";
          path = "/opt/stalwart/compose.yaml";
          symlink = false;
          mode = "0644";
        };

        stalwart = {
          rekeyFile = "stalwart-config.toml.age";
          path = "/opt/stalwart/stalwart/etc/config.toml";
          symlink = false;
          mode = "0644";
        };

        traefik = {
          rekeyFile = "stalwart-traefik.yml.age";
          path = "/opt/stalwart/loadbalancer/traefik.yml";
          symlink = false;
          mode = "0644";
        };
      };
    };
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  # Used to generate a FQDN in the internal contabo network
  networking = {
    domain = "contaboserver.net";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # ssh
        22
        # http + https
        80
        443
        # stalwart ports
        143
        993
        587
        465
        110
        995
        4190
      ];
    };
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJO3cs5ldXTibguhJQKwopdssnfGwwIHS5vyOQTvzbm christopher@cobalt"];

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    vim
  ];

  system.activationScripts = {
    dockerNetwork = {
      text = ''
        # Don't fail in case the network can't be created (in case it already exists)
        ${pkgs.docker}/bin/docker network create traefik-proxy || true
      '';
    };
  };

  users.users.stalwart = {
    home = "/opt/stalwart";
    isSystemUser = true;
    group = "stalwart";
    extraGroups = ["docker"];
  };

  users.groups.stalwart = {};
}
