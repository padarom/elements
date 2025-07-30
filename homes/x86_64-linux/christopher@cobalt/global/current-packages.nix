{
  config,
  pkgs,
  ...
}: {
  home.file.".cache/current-home-manager-packages".text = let
    packages = builtins.map (p: "${p.name}") config.home.packages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
