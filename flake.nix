{
  description = "Basic NixOS configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    nixpkgs-sagemath-10_5.url = "github:NixOS/nixpkgs/bd3bac8bfb542dbde7ffffb6987a1a1f9d41699f";
    nixpkgs-sagemath-10_5.inputs.nixpkgs.follows = "nixpkgs";
    macaulay2-build = {
      url = "github:pdg137/macaulay2-build";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix4nvchad,
    additional-fonts,
    nixpkgs-sagemath-10_5,
    macaulay2-build,
    ...
  }: let
    system = "x86_64-linux";
    username = "tesserekt";
    fonts-overlay = final: prev: {
      palatino-font = additional-fonts.packages.${system}.palatino;
    };
    pkgs-sage10_5 = import nixpkgs-sagemath-10_5 {
      inherit system;
      config = {allowUnfree = true;};
    };
    sagemath-overlay = final: prev: {
      sage = pkgs-sage10_5.sage;
    };
    macaulay2-overlay = final: prev: {
      macaulay2-pkgs = (import macaulay2-build) { pkgs = final; };
      macaulay2 = final.macaulay2-pkgs.M2-stable;
    };
  in {
    nixosConfigurations.tesserekt-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
        hostname = "tesserekt-pc";
      };
      modules = [
        ./configuration.nix
        ./boot-loader-pc.nix
        ./hw-pc.nix
        ./amd.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay sagemath-overlay];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username} = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs username;
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
        {nixpkgs.overlays = [fonts-overlay sagemath-overlay];}

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
        {nixpkgs.overlays = [fonts-overlay sagemath-overlay macaulay2-overlay];}

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
