{
  pkgs,
  inputs,
  ...
}: let
  #ruby = pkgs."ruby-2.5";
  #bundler = pkgs.bundler.override { inherit ruby; };
in {
  home.packages = with pkgs; [
    # docker has to be installed globally because we have to enable virtualization
    inputs.docker-compose-1.legacyPackages."x86_64-linux".docker-compose

    # Ruby environment
    # bundler
    # ruby
    bundix

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
