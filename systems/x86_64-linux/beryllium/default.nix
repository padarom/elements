# ++ 4_Be: Beryllium
#
# NUC / HomeLab environment
{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./disks.nix
  ];

  elements = {
    hostname = "beryllium";
    users = ["christopher"];
    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUKDCjB0VpQubi8BfnYKbh4MIE1tcvKQesdoPE4NXAf";
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

    apcupsd.enable = true;
  };

  # Enable privileged ports for rootless pods
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = "0";

  environment.systemPackages = with pkgs; [
    helix
    podman-compose
  ];
}
