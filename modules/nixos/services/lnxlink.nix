{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.services.lnxlink;

  lnxlink = pkgs.python3Packages.buildPythonApplication {
    pname = "lnxlink";
    version = "2025.7.0";
    pyproject = true;

    # Linking my fork here which allows for newer versions of setuptools and wheel.
    # Also includes some fixes that make the program actually work with NixOS.
    src = pkgs.fetchFromGitHub {
      owner = "padarom";
      repo = "lnxlink";
      rev = "7202e48";
      hash = "sha256-E2J1d9D5SJWGEutAPAo1BM98cMzH7QrqIz3yrlXpzGE=";
    };

    build-system = with pkgs.python3Packages; [setuptools wheel];
    dependencies = with pkgs.python3Packages; [
      distro
      pyyaml
      paho-mqtt
      requests
      psutil
      inotify
      jeepney
    ];

    meta = {
      homepage = "https://github.com/bkbilly/lnxlink";
      description = "Effortlessly manage your Linux machine using MQTT.";
      license = licenses.mit;
      mainProgram = "lnxlink";
    };
  };
in {
  options.services = {
    lnxlink = {
      enable = mkEnableOption "Enable LNXlink";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [lnxlink];

    systemd.services.lnxlink = {
      enable = true;
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        # Note: Logging will also be done to the working directory, so logs will
        # be lost upon a restart.
        WorkingDirectory = "/tmp";
        ExecStart = "${lnxlink}/bin/lnxlink -i -c ${./lnxlink.yaml}";
      };
    };
  };
}
