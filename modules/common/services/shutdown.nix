{pkgs, ...}: let
  # The command to run in order to shut down the computer
  command = "${pkgs.systemd}/bin/systemctl poweroff -i";

  # Write this command into a shell script
  bin = pkgs.writeShellScriptBin "shutdown" command;
in {
  users.users.hass = {
    isNormalUser = true;
    home = "/home/hass";
    description = "HomeAssistant automations";
    extraGroups = [];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzLKowPwiQtAIgrY1wSvdolcDkbXokWrda//EEzQfR5 root@homeassistant"];
  };

  # Create a symlink to the shell script we created to the absolute path
  # /etc/shutdown-script
  environment.etc.shutdown-script.source = "${bin}/bin/shutdown";

  security.sudo.extraRules = [
    {
      users = ["hass"];
      commands = [
        {
          # Allow the 'hass' user to run the shutdown script
          command = "/etc/shutdown-script";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Allow the 'hass' user to log in, but not via password authentication.
  # The authorized key is specified above.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["hass"];
    };
  };
}
