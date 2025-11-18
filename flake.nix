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
          disko.nixosModules.default
          agenix.nixosModules.default
          agenix-rekey.nixosModules.default
          ./modules/common
        ];
        darwin = [
          agenix.darwinModules.default
          agenix-rekey.nixosModules.default
          ./modules/common
        ];
      };

      # Add modules only to specific hosts
      systems.hosts = with inputs; {
        cobalt.modules = [
          musnix.nixosModules.default
        ];
        beryllium.modules = [
          quadlet.nixosModules.quadlet
        ];
        europium.modules = [
          quadlet.nixosModules.quadlet
        ];
      };

      homes.users = {
        "christopher@beryllium".modules = with inputs; [
          quadlet.homeManagerModules.quadlet
        ];
      };

      # Configure nixpkgs when instantiating the package set
      # TODO: This is already specified elsewhere. Still needed here?
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      overlays = with inputs; [];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    })
    // {
      agenix-rekey = inputs.agenix-rekey.configure {
        userFlake = inputs.self;
        nixosConfigurations = inputs.self.nixosConfigurations // inputs.self.darwinConfigurations;
        homeConfigurations = inputs.self.homeConfigurations;
      };
    };

  inputs = {
    # nixpkgs.url = "git+file:///home/christopher/code/opensource/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Opinionated flake library for better organization without much boilerplate
    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      # url = "git+file:///home/christopher/code/opensource/home-manager";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For using home-manager on Darwin (macOS) devices
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Disk management via Nix
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets management
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

    affinity-nix.url = "github:mrshmllow/affinity-nix";
    quadlet.url = "github:SEIAROTg/quadlet-nix";
    musnix.url = "github:musnix/musnix";
    docker-compose-1.url = github:nixos/nixpkgs/b0f0b5c6c021ebafbd322899aa9a54b87d75a313;
  };
}
