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
    lsprotocol-fix = final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pfinal: pprev: {
          lsprotocol =
            pprev.lsprotocol.overridePythonAttrs
            (oldAttrs: {
              version = "2023.0.1";

              src = final.fetchFromGitHub {
                owner = "microsoft";
                repo = "lsprotocol";
                tag = "2023.0.1";
                hash = "sha256-PHjLKazMaT6W4Lve1xNxm6hEwqE3Lr2m5L7Q03fqb68=";
              };
            });
        };
      };
    };
    sagemath-ecm-fix = final: prev: {
      ecm = prev.ecm.overrideAttrs (oldAttrs: {
        NIX_CFLAGS_COMPILE = (oldAttrs.NIX_CFLAGS_COMPILE or "") + " -Wno-implicit-function-declaration";
      });
    };
    sagemath-rpy-fix = final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pfinal: pprev: {
          rpy2 = pprev.rpy2.overridePythonAttrs (oldAttrs: {
            patches = [];
            postPatch = "";
            format = "pyproject";
            nativeBuildInputs =
              (oldAttrs.nativeBuildInputs or [])
              ++ [
                pfinal.setuptools
                pfinal.wheel
              ];
            doPythonRuntimeDepsCheck = false;
          });
        };
      };
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
        {nixpkgs.overlays = [fonts-overlay];}

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
        {nixpkgs.overlays = [fonts-overlay lsprotocol-fix];}

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
        {nixpkgs.overlays = [fonts-overlay lsprotocol-fix sagemath-ecm-fix sagemath-rpy-fix];}

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
