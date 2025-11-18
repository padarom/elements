{lib, ...}: pkgs: {
  /*
  The name of the script to write.

  Type: String
  */
  name,
  /*
  The shell script's text, not including a shebang.

  Type: String
  */
  text,
  /*
  Inputs to add to the shell script's `$PATH` at runtime.

  Type: [String|Derivation]
  */
  runtimeInputs ? [],
  /*
  Extra environment variables to set at runtime.

  Type: AttrSet
  */
  runtimeEnv ? null,
  /*
  `stdenv.mkDerivation`'s `meta` argument.

  Type: AttrSet
  */
  meta ? {},
  /*
  `stdenv.mkDerivation`'s `passthru` argument.

  Type: AttrSet
  */
  passthru ? {},
  /*
  The `checkPhase` to run. Defaults to `shellcheck` on supported
  platforms and `bash -n`.

  The script path will be given as `$target` in the `checkPhase`.

  Type: String
  */
  checkPhase ? null,
  /*
  Extra arguments to pass to `stdenv.mkDerivation`.

  :::{.caution}
  Certain derivation attributes are used internally,
  overriding those could cause problems.
  :::

  Type: AttrSet
  */
  derivationArgs ? {},
  /*
  Whether to inherit the current `$PATH` in the script.

  Type: Bool
  */
  inheritPath ? true,
}: let
  nu = pkgs.nushell;
in
  pkgs.writeTextFile {
    inherit
      name
      meta
      passthru
      derivationArgs
      ;
    executable = true;
    destination = "/bin/${name}";
    allowSubstitutes = true;
    preferLocalBuild = false;

    text =
      ''
        #!${nu}${nu.shellPath}

        use std/util "path add"
      ''
      + lib.optionalString (runtimeEnv != null) (
        lib.concatMapAttrsStringSep "" (name: value: ''
          $env.${lib.toShellVar name value}
          export ${name}
        '')
        runtimeEnv
      )
      + lib.optionalString (runtimeInputs != []) (''
          ${lib.optionalString (! inheritPath) "$env.PATH = []"}
        ''
        + lib.concatStringsSep ":" (map (path: ''
            path add '${path}/bin'
          '')
          runtimeInputs))
      + text;

    checkPhase =
      if checkPhase == null
      then ''
        runHook preCheck
        ${nu}${nu.shellPath} -c "nu-check --debug $target"
        runHook postCheck
      ''
      else checkPhase;
  }
