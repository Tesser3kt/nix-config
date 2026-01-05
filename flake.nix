{
  description = "Basic NixOS configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-sage.url = "github:NixOS/nixpkgs/nixos-25.11";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:Tesser3kt/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-starter = {
      url = "github:Tesser3kt/nvchad-starter";
      flake = false;
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
    additional-fonts = {
      url = "github:jeslie0/fonts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix4nvchad,
    additional-fonts,
    ...
  }: let
    system = "x86_64-linux";
    username = "tesserekt";
    fonts-overlay = final: prev: {
      palatino-font = additional-fonts.packages.${system}.palatino;
    };
    ltrace-overlay = final: prev: {
      ltrace = prev.ltrace.overrideAttrs (_: {
        doCheck = false;
      });
    };
    pkgsSage = import inputs.nixpkgs-sage {inherit system;};
  in {
    nixosConfigurations.tesserekt-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username pkgsSage;
        hostname = "tesserekt-pc";
      };
      modules = [
        ./configuration.nix
        ./boot-loader-pc.nix
        ./hw-pc.nix
        ./amd.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay ltrace-overlay];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username} = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs username pkgsSage;
            displayConfig = "pc";
            waybarConfig = "pc";
            startupConfig = "pc";
            deviceConfig = "pc";
            graphics = "amd";
            gpgKeygrip = "91957720EE42E89A4DDF080DE22E95D7E3E98FA4";
          };
        }
      ];
    };
    nixosConfigurations.tesserekt-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
        hostname = "tesserekt-laptop";
      };
      modules = [
        ./configuration.nix
        ./boot-loader-laptop.nix
        ./hw-laptop.nix
        ./intel.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay ltrace-overlay];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username} = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs username;
            displayConfig = "laptop";
            waybarConfig = "laptop";
            startupConfig = "laptop";
            deviceConfig = "laptop";
            graphics = "intel";
            gpgKeygrip = "FD108A1438702B075EB5921DFA9C798F7614F016";
          };
        }
      ];
    };
    nixosConfigurations.tesserekt-raider = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
        hostname = "tesserekt-raider";
      };
      modules = [
        ./configuration.nix
        ./boot-loader-raider.nix
        ./hw-raider.nix
        ./nvidia.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username} = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs username;
            displayConfig = "raider";
            waybarConfig = "laptop";
            startupConfig = "raider";
            deviceConfig = "raider";
            graphics = "nvidia";
            gpgKeygrip = "4D7F773E7B92A663FDF2BF2BA723378E50AAE17A";
          };
        }
      ];
    };
  };
}
