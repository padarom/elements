# ++ 80_Hg: Mercury
#
# Minimal environment for a workbase VirtualBox on macOS
{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib._elements; {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  elements = {
    hostname = "mercury";
    users = ["christopher"];
    quirks = ["avahi" "docker"];

    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjqieS4GkYAa1WRYZpxjgYsj7VGZ9U+rTFCkX8M0umD";
    };
  };

  system.stateVersion = "24.11";

  # Enable nix flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["christopher"];
    };
  };

  # Set the default drive, which in the case of Mercury is
  # a VirtualBox image.
  disko.devices.disk.main.device = "/dev/sda";

  boot.loader.grub.enable = true;
  networking.hostName = "mercury";
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    inputs.docker-compose-1.legacyPackages."x86_64-linux".docker-compose
    gnumake
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "de";
  };

  programs.vim.enable = true;
  programs.git.enable = true;

  # Disable the firewall so that all traffic is allowed
  networking.firewall.enable = false;

  # Reflect mDNS to host network
  services.avahi.reflector = true;

  # Forward external traffic internally
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
