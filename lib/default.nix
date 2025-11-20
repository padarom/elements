{lib, ...} @ all: rec {
  rootPath = ./..;
  secret = name: ./../secrets/${name};

  commonHomeModule = module: ./../homes/common + "/${module}";
  writeNushellApplication = import ./writeNushellApplication.nix {inherit lib;};

  # Determines the file location of the passed in attr set (e.g. `{ sep = "#"; })
  # and prepends the string with it. This allows to add references to the source
  # file that wrote any setting to generated application configurations for debugging.
  selfReferencedString = {sep} @ attrs: str: let
    ref = builtins.unsafeGetAttrPos "sep" attrs;
  in
    "${sep} ${ref.file}:${builtins.toString ref.line}\n" + str;

  enabled = {enable = true;};
  disabled = {enable = false;};

  agenixRekeyConfig = self: config: {
    rekey = {
      hostPubkey = config.key;

      # See https://github.com/oddlama/agenix-rekey?tab=readme-ov-file#local for
      # potential effects of this decision.
      storageMode = "local";
      localStorageDir = self + "/secrets/rekeyed/${config.rekeyPath}";

      # Used to decrypt stored secrets for rekeying.
      masterIdentities = [
        (self + "/secrets/keys/master-identity.pub")
      ];

      # Keys that will always be encrypted for. These act as backup keys in case the
      # master identities are somehow lost.
      extraEncryptionPubkeys = [
        "age1zd8wxnmgf04qcan9cvs0736valy8407f497fw9j0auwf072yadzqqdqsj9"
      ];
    };

    secrets =
      lib.attrsets.mapAttrs
      (
        name: secret: (
          if builtins.isString secret
          then {rekeyFile = self + "/secrets/${secret}";}
          else secret // {rekeyFile = self + "/secrets/${secret.rekeyFile}";}
        )
      )
      config.needs;
  };
}
