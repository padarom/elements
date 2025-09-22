{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./disko.nix
  ];

  elements.secrets.needs.smbSecrets = "smb-secrets.age";

  # Set up two main drives for RAID 1
  disko.devices.disk = {
    one.device = "/dev/sda";
    two.device = "/dev/sdb";
  };

  # Install GRUB to both drives (/boot and /boot2) so that we'll be able to boot
  # even if one of them fails
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

  # Mount the NAS locally via CIFS (Windows share)
  fileSystems = builtins.listToAttrs (
    map (v: {
      name = "/mnt/nuc/${v}";
      value = {
        device = "//10.1.0.1/${v}";
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in ["${automount_opts},credentials=${config.age.secrets.smbSecrets.path},uid=1000,gid=100,vers=1.0"];
      };
    }) ["_NAS_Media" "Ix"]
  );

  environment.systemPackages = [pkgs.cifs-utils];
}
