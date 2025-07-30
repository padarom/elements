{config, ...}: let
  mountpoint = "${config.home.homeDirectory}/OneDrive";
in {
  # onedriver sets up its own systemd service.
  programs.onedrive = {
    enable = true;
    # settings = {
    #   skip_dir = "Dokumente|Backup";
    #   skip_dir_strict_match = "true";
    # };
  };

  home.file."Dokumente".source = config.lib.file.mkOutOfStoreSymlink "${mountpoint}/_EchteDokumente";
}
