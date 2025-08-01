{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.beszel
    pkgs.rocmPackages.rocm-smi # Interface with AMD GPUs
  ];

  systemd.services.beszel-agent = {
    enable = true;
    description = "Beszel Agent (remote monitoring)";

    environment = {
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkUPOw28Cu2LMuzfmvjT/L2ToNHcADwGyGvSpJ4wH2T";
      LISTEN = "45876";
    };

    serviceConfig = {
      ExecStart = "${pkgs.beszel}/bin/beszel-agent";
    };
  };
}
