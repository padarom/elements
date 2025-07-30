{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.elements;
in
  with lib;
  with builtins; {
    options = {
      elements = {
        users = mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };

    config = let
      mkIfUser = name: mkIf (elem name cfg.users);
      #secretFor = name: file: mkIfUser name {rekeyFile = ./../../../.. + "/secrets/${file}";};
    in {
      # age.secrets.christopher-password = secretFor "christopher" "christopher-password.age";

      users = {
        users.christopher = mkIfUser "christopher" {
          isNormalUser = true;
          # passwordFile = config.age.secrets.christopher-password.path;
          shell = pkgs.nushell;
          extraGroups = [
            "wheel"
            "docker"
            "dialout"
            "uinput"
            "pico"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEqcR3f71g7yuxQtUewrqdoEh8jDHtkB1973GF0EQ6q christopher@all"
          ];
        };

        groups.christopher = {
          members = ["christopher"];
          gid = 1000;
        };
      };
    };
  }
