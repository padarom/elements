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

    # wine
    #(wineWowPackages.stable.override {waylandSupport = true;})
    #winetricks

    gamemode # performance mode
    mangohud # performance overlays
  ];
}
