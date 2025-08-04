{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eww
    lm_sensors
  ];

  home.file."${config.xdg.configHome}/eww" = {
    source = ./eww;
    recursive = true;
  };
}
