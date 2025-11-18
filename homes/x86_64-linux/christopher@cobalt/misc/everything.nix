{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gnupg
    unzip
    dua # Interactively view disk space usage
    numbat # Scientific calculations
    yubikey-manager
    croc # File transfer
    solaar # Logitech mouse driver
    btop # Better resource monitor
    bottom # System resource monitor
    grim # Screenshots
    slurp # Region selection

    # GUI
    slack # Work chat
    vesktop # Discord client
    vlc # Video player
    obsidian # Note taking
    calibre # eBook Manager
    onlyoffice-desktopeditors # libreoffice alternative
    filezilla # FTP Client
    orca-slicer # Bambu Lab Slicer + Control
    krita # Drawing software
    inputs.affinity-nix.packages.${pkgs.system}.v3 # Affinity
    mochi # SRS flashcards
    thunderbird # Email client
    speedcrunch # GUI calculator app
    naps2 # Scanning
    vcv-rack # Eurorack simulator
    davinci-resolve # Video editor
    cider-2 # Apple music player

    xarchiver # Archive viewer/extractor
    zathura # Document viewer
    evince # Document viewer
  ];
}
