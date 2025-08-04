{
  # References:
  #   * https://github.com/Misterio77/nix-starter-config
  description = "Padarom's system configuration";

  outputs = {self, ...} @ inputs:
    (inputs.snowfall.mkFlake {
      inherit inputs;
      src = ./.;

      # Exposes all internal libs and packages as `lib._elements` or `pkgs._elements` respectively
      snowfall.namespace = "_elements";

      # Global system modules to be included for all systems
      systems.modules = with inputs; {
        nixos = [
          agenix.nixosModules.default
          agenix-rekey.nixosModules.default
        ];
        darwin = [];
      };

      # Add modules only to specific hosts
      systems.hosts = with inputs; {
        cobalt.modules = [
          grub2-themes.nixosModules.default
        ];
      };

      # Configure nixpkgs when instantiating the package set
      # TODO: This is already specified elsewhere. Still needed here?
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    })
    // {
      agenix-rekey = inputs.agenix-rekey.configure {
        userFlake = inputs.self;
        nixosConfigurations = inputs.self.nixosConfigurations;
        homeConfigurations = inputs.self.homeConfigurations;
      };
    };

  inputs = {
    # nixpkgs.url = "git+file:///home/christopher/code/opensource/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Opinionated flake library for better organization without much boilerplate
    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For using home-manager on Darwin (macOS) devices
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      # url = "git+file:///home/christopher/code/opensource/home-manager";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/hyprland";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    docker-compose-1.url = github:nixos/nixpkgs/b0f0b5c6c021ebafbd322899aa9a54b87d75a313;

    grub2-themes.url = github:vinceliuice/grub2-themes;
    grub2-themes.inputs.nixpkgs.follows = "nixpkgs";
  };
}
