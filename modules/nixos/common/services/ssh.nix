{pkgs, ...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["christopher"];
    };
  };
}
