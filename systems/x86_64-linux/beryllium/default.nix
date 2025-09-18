# ++ 4_Be: Beryllium
#
# NUC / HomeLab environment
{
  lib,
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
    };
  };

  users.users.christopher.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVKJfY6B9TsUPdPXy3tkqL42sJgJRz3NOOKTqhytMMf christopher@cobalt"];

  services = {
    openssh.enable = true;
    openssh.ports = [7319];
    openssh.settings.PasswordAuthentication = false;

    beszel-agent.enable = true;
    beszel-agent.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkUPOw28Cu2LMuzfmvjT/L2ToNHcADwGyGvSpJ4wH2T";
  };

  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
