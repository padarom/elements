{pkgs, ...}: {
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

    # GUI
    vesktop # Discord client
    vlc # Video player
    obsidian # Note taking
    calibre # eBook Manager
    onlyoffice-bin # libreoffice alternative
    filezilla # FTP Client
    orca-slicer # Bambu Lab Slicer + Control
    krita # Drawing software
    mochi # SRS flashcards
    thunderbird # Email client
    speedcrunch # GUI calculator app
    naps2 # Scanning
    vcv-rack # Eurorack simulator
    davinci-resolve # Video editor

    feh # Image viewer
    xarchiver # Archive viewer/extractor
    zathura # Document viewer
    evince # Document viewer
  ];
}
