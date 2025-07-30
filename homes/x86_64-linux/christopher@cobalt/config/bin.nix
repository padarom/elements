{pkgs, ...}: {
  home.packages = with pkgs; [
    jq # JSON processor
    yq # YAML processor
    jo # Construct JSON via CLI
    socat # Socket cat
    gum
  ];
}
