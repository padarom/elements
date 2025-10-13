# ++ 27_Co: Cobalt
#
# Main tower workstation environment
{
  pkgs,
  lib,
  config,
  ...
}:
with lib._elements; {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  elements = {
    hostname = "cobalt";
    users = ["christopher"];
    quirks = ["avahi" "docker" "nix-ld"];
    wm = enabled;

    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjqieS4GkYAa1WRYZpxjgYsj7VGZ9U+rTFCkX8M0umD";

      needs = {
        copypartyPassword = rec {
          owner = "christopher";
          group = owner;
          rekeyFile = "copyparty-password.age";
        };
      };
    };
  };

  # Set the default drive
  disko.devices.disk.main.device = "/dev/nvme1n1";

  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  networking = {
    hostName = "cobalt";
    firewall.enable = false;
    interfaces.eno1.wakeOnLan.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  programs = {
    weylus.users = ["christopher"];

    dconf.enable = true;

    steam = {
      enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
    };
    # VR support
    envision.enable = true;

    # For game-related system optimisations
    gamemode.enable = true;

    _1password.enable = true;
    _1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = ["christopher"];
    };
  };

  services = {
    openssh.enable = true;
    openssh.settings.PasswordAuthentication = false;

    # Bluetooth manager
    blueman.enable = true;
    udev.packages = [pkgs.platformio-core.udev];

    # Linux link via MQTT
    lnxlink.enable = true;
    beszel-agent.enable = true;
    beszel-agent.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkUPOw28Cu2LMuzfmvjT/L2ToNHcADwGyGvSpJ4wH2T";

    pipewire = {
      enable = lib.mkForce true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };

    # Automatic mounting of removable media
    udisks2.enable = true;

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    gvfs.enable = true; # Mount/trash/...
    tumbler.enable = true; # Thumbnail support in Thunar

    gnome.gnome-keyring.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
      ];
    };

    logind.extraConfig = ''
      RuntimeDirectorySize=6G
    '';

    # Smartcard support, necessary for Yubikey logins
    pcscd.enable = true;

    copyparty = {
      enable = false;
      user = "christopher";

      settings = {
        i = "0.0.0.0";
      };

      accounts.c.passwordFile = config.age.secrets.copypartyPassword.path;

      volumes = {
        "/" = {
          path = "/home/christopher";
          access.rwmdga = "c";
          flags = {
            fk = 4;
            scan = 60;
            e2d = true;
          };
        };
        "/hdd" = {
          path = "/mnt/hdd";
          access.rwmdga = "c";
          flags = {
            fk = 4;
            scan = 60;
            e2d = true;
          };
        };
      };
    };
  };

  programs = {
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSSHSupport = true;
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      # Global apps
      vim
      wget
      htop
      gnumake
      libnotify
      gtk3

      lact # GPU tuning
      libimobiledevice
      ifuse

      # Oxidized coreutils
      uutils-coreutils-noprefix

      wally-cli
      keymapp
      pavucontrol

      nix-tree
      nix-output-monitor

      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };

  users.groups.pico = {};

  systemd.packages = [pkgs.lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  hardware = {
    amdgpu = {
      opencl.enable = true;
      overdrive.enable = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # SANE scanner support
    sane = {
      enable = true;
      extraBackends = [pkgs.brscan4];
    };

    # Input emulation from userspace (see weylus).
    uinput.enable = true;

    # Enable zsa keyboard (Moonlander) support.
    keyboard.zsa.enable = true;
  };

  system.stateVersion = "23.05"; # Do not change this value!

  # Set up our bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };
}
