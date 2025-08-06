{lib, ...}: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  system.stateVersion = lib.mkDefault "24.11";

  time.timeZone = lib.mkDefault "Europe/Berlin";
}
