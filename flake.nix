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
    fonts-overlay = final: prev: {
      palatino-font = additional-fonts.packages.${system}.palatino;
    };
  in {
    nixosConfigurations.tesserekt-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
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

          home-manager.users.tesserekt = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            displayConfig = "pc";
            waybarConfig = "pc";
            startupConfig = "pc";
            deviceConfig = "pc";
          };
        }
      ];
    };
    nixosConfigurations.tesserekt-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./boot-loader-laptop.nix
        ./hw-laptop.nix
        ./intel.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.tesserekt = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            displayConfig = "laptop";
            waybarConfig = "laptop";
            startupConfig = "laptop";
          };
        }
      ];
    };
  };
}
