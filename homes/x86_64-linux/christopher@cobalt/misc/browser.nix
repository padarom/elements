{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    vivaldi
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
    enable = true;
    resyncTimer = "10m";
  };
}
