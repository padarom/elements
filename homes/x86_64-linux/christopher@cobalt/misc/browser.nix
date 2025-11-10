{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "open-url.desktop";
      "x-scheme-handler/https" = "open-url.desktop";
    };
  };

  # profile-sync-daemon manages browser profiles in tmpfs
  services.psd = {
    enable = false;
    # resyncTimer = "10m";
  };
}
