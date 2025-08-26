{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # docker has to be installed globally because we have to enable virtualization
    inputs.docker-compose-1.legacyPackages."x86_64-linux".docker-compose

    ruby_3_2

    # Dev environment specifics
    libxcrypt # maklerportal-frontend-test-suite
    postgresql
    geos

    # mDNS support
    nssmdns
    avahi

    slack
  ];
}
