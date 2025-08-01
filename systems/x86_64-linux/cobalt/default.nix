# ++ 27_Co: Cobalt
#
# Main tower workstation environment
{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib._elements; {
  imports = [
    ./hardware.nix
    "${builtins.fetchTarball {
      url = "https://github.com/nix-community/disko/archive/master.tar.gz";
      sha256 = "0mzm7digdksivdhikxvrx6l0j2b9lj167ndcimsy9i24k4b91wsk";
    }}/module.nix"
    ./disk-config.nix
    ./beszel-agent.nix

    ./wayland.nix
    "${inputs.self}/modules/nixos/common/services/shutdown.nix"
  ];

  elements = {
    hostname = "cobalt";
    users = ["christopher"];
    quirks = ["avahi" "docker" "nix-ld"];

    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjqieS4GkYAa1WRYZpxjgYsj7VGZ9U+rTFCkX8M0umD";
    };
  };

  # Set the default drive
  disko.devices.disk.main.device = "/dev/nvme1n1";

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  networking = {
    hostName = "cobalt";
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  xdg.portal = {
    enable = true;
    config.common.default = ["hyprland"];
    config.hyprland.default = ["wlr" "gtk"];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
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
    # Bluetooth manager
    blueman.enable = true;

    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pipewire.enable = lib.mkForce false;

    # Automatic mounting of removable media
    udisks2.enable = true;

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

    # Smartcard support, necessary for Yubikey logins
    pcscd.enable = true;
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

    zsh.enable = true;
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
      xarchiver # GUI archiving tool, used with Thunar

      lact

      # Oxidized coreutils
      uutils-coreutils-noprefix

      wally-cli
      keymapp

      # SANE frontend
      xsane

      # Desktop environment
      pavucontrol
      eww

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
      #  amdvlk = {
      #    enable = true;
      #    support32Bit.enable = true;
      #  };
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
      gfxmodeEfi = lib.mkForce "3840x1080,auto";
      gfxmodeBios = lib.mkForce "3840x1080,auto";
    };
    grub2-theme = {
      enable = true;
      icon = "white";
      theme = "tela";
      screen = "ultrawide2k";
      # resolution = "3840x1080";
    };
  };
}
