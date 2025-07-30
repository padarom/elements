{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  config = lib.mkIf (builtins.elem "avahi" config.elements.quirks) {
    services = {
      # Name Server Caching Daemon
      nscd = {
        enable = true;
        enableNsncd = true;
      };

      # Avahi mDNS service discovery
      avahi = {
        enable = true;

        # Due to some quirk this has to stay disabled. Instead, we have to specify
        # system.nssModules = [pkgs.nssmdns];
        nssmdns4 = false;
        ipv6 = false;

        publish = {
          enable = true;
          addresses = true;
          domain = true;
          userServices = true;
          workstation = true;
        };
      };
    };

    system = {
      nssModules = [pkgs.nssmdns];

      # This order is required for avahi to work (uses mdns4 rather than mdns_minimal).
      nssDatabases.hosts = lib.mkForce ["files myhostname mdns4 [NOTFOUND=return] resolve [!UNAVAIL=return] dns"];
    };
  };
}
