{pkgs, ...}: {
  # TODO: Move these into individual modules rather than a catch-all
  home.packages = with pkgs; [
    gnupg
    unzip
    dua # Interactively view disk space usage
    tldr # Quick man-page replacement
    hyperfine # Terminal benchmarks
    numbat # Scientific calculations
    hexyl # Hex viewer
    pastel # Color analyzer
    yubikey-manager
    croc # File transfer
    zotero # Collect research sources
    solaar # Logitech mouse driver
    btop # Better resource monitor
    bottom # System resource monitor

    # GUI
    vcv-rack # Audio synthesizer/eurorack simulator
    vlc # Video player
    todoist-electron # Todo application
    logseq # Knowledge Base
    obsidian # Same as above
    calibre # eBook Manager
    vesktop # Discord Messenger
    obs-studio # OBS Studio
    wasistlos # WhatsApp client
    libreoffice # Productivity Suite (like Microsoft Office)
    cider # Apple Music player
    filezilla # FTP Client
    zathura # Document viewer
    orca-slicer # Bambu Lab Slicer + Control
    weylus # Use iPad Pro as graphics tablet
    krita # Drawing software
    mochi # SRS flashcards
    # spacedrive # File explorer (Alpha, not usable yet)
    thunderbird # Email client
    speedcrunch # GUI calculator app
    shotcut # Video editing
    naps2 # Scanning

    feh # Image viewer
    xarchiver # Archive viewer/extractor
    evince # Document viewer
  ];
}
