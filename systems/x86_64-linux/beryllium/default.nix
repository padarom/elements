# ++ 4_Be: Beryllium
#
# NUC / HomeLab environment
{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  # Set up two main drives for RAID 1
  disko.devices.disk = {
    one.device = "/dev/sda";
    two.device = "/dev/sdb";
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        mirroredBoots = [
          {
            devices = ["/dev/sda"];
            path = "/boot";
          }
          {
            devices = ["/dev/sdb"];
            path = "/boot2";
          }
        ];
      };
    };

    # Set up mdmon to notify me when one of the drives fails
    swraid.mdadmConf = ''
      MAILADDR raid@muehl.dev
    '';
  };

  elements = {
    hostname = "beryllium";
    users = ["christopher"];
    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUKDCjB0VpQubi8BfnYKbh4MIE1tcvKQesdoPE4NXAf";
      needs = {
        smbSecrets = "smb-secrets.age";
      };
    };
  };

  networking.firewall.enable = false;
  networking.dhcpcd.IPv6rs = false;

  users.users.christopher.linger = true; # autostart of quadlets before login
  users.users.christopher.autoSubUidGidRange = true;
  users.users.christopher.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVKJfY6B9TsUPdPXy3tkqL42sJgJRz3NOOKTqhytMMf christopher@cobalt"];
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVKJfY6B9TsUPdPXy3tkqL42sJgJRz3NOOKTqhytMMf christopher@cobalt"];

  services = {
    openssh = {
      enable = true;
      ports = [7319];
      settings.PasswordAuthentication = false;
    };

    beszel-agent = {
      enable = true;
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkUPOw28Cu2LMuzfmvjT/L2ToNHcADwGyGvSpJ4wH2T";
    };
  };

  boot.kernel.sysctl = {
    # We require this so that a rootless traefik can bind to port 80.
    "net.ipv4.ip_unprivileged_port_start" = "80";
  };

  # virtualisation.quadlet.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings = {
      dns_enabled = true;
      # Override the default subnet as it overlaps with my LAN.
      subnets = [
        {
          gateway = "172.16.0.1";
          subnet = "172.16.0.0/16";
        }
      ];
    };
  };

  fileSystems."/mnt/nuc/_NAS_Media" = {
    device = "//10.1.0.1/_NAS_Media";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.age.secrets.smbSecrets.path},uid=100999,gid=10999,vers=1.0"];
  };

  fileSystems."/mnt/nuc/Ix" = {
    device = "//10.1.0.1/Ix";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.age.secrets.smbSecrets.path},uid=100999,gid=10999,vers=1.0"];
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    helix
    podman-compose
  ];
}
