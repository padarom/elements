{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher # minecraft launcher
    heroic # gog/epic launcher

    # game manager
    (lutris.override {
      extraLibraries = pkgs:
        with pkgs; [
          libadwaita
          libunwind
          gtk4
        ];
    })

    gamescope
    gamemode # performance mode
    mangohud # performance overlays
    alvr
  ];
}
