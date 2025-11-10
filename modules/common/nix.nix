{
  self,
  pkgs,
  config,
  ...
}: {
  nix.settings = {
    # auto-optimize-store = true;
    # builders-use-substitutes = true;
    experimental-features = ["nix-command" "flakes"];
    flake-registry = "/etc/nix/registry.json";

    keep-derivations = true;
    keep-outputs = true;

    trusted-users = ["root" "@wheel"];

    substituters = [
      "https://cache.nixos.org/"
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "nixos-config"
      "electron-27.3.11"
      "dotnet-sdk-6.0.428"
    ];
  };

  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
