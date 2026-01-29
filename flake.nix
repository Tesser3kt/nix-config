{
  description = "Basic NixOS configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
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
    ffmpegAvMallocFix = final: prev: let
      patch = final.writeText "ffmpeg-av_malloc-tablegen.patch" ''
        diff --git a/libavcodec/vlc.c b/libavcodec/vlc.c
        index 0000000..0000000 100644
        --- a/libavcodec/vlc.c
        +++ b/libavcodec/vlc.c
        @@ -1,6 +1,12 @@
         #include <inttypes.h>
         #include <stdint.h>
         #include <stdlib.h>
         #include <string.h>
        +
        +/* tablegen builds may predefine AVUTIL_MEM_H (via tableprint_vlc.h),
        + * which prevents mem.h from providing av_malloc() prototypes. */
        +#ifdef AVUTIL_MEM_H
        +#undef AVUTIL_MEM_H
        +#endif
         #include "libavutil/attributes.h"
         #include "libavutil/avassert.h"
         #include "libavutil/error.h"
         #include "libavutil/internal.h"
         #include "libavutil/intreadwrite.h"
         #include "libavutil/log.h"
         #include "libavutil/macros.h"
         #include "libavutil/mem.h"
      '';

      fix = pkg:
        pkg.overrideAttrs (old: {
          patches = (old.patches or []) ++ [patch];
        });
    in {
      # Patch whatever exists in that nixpkgs
      ffmpeg-full = fix prev.ffmpeg-full;
      ffmpeg_7-full =
        if prev ? ffmpeg_7-full
        then fix prev.ffmpeg_7-full
        else prev.ffmpeg_7-full;
    };
    pkgsStable = import inputs.nixpkgs-stable {inherit system;};
  in {
    nixosConfigurations.tesserekt-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username pkgsStable;
        hostname = "tesserekt-pc";
        openrgbEnabled = true;
        coolercontrolEnabled = true;
        corsairEnabled = false;
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
            inherit inputs username pkgsStable;
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
        inherit inputs username pkgsStable;
        hostname = "tesserekt-laptop";
        openrgbEnabled = false;
        coolercontrolEnabled = false;
        corsairEnabled = false;
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
            inherit inputs username pkgsStable;
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
    nixosConfigurations.tesserekt-nvidia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username pkgsStable;
        hostname = "tesserekt-nvidia";
        openrgbEnabled = false;
        coolercontrolEnabled = false;
        corsairEnabled = true;
      };
      modules = [
        ./configuration.nix
        ./boot-loader-nvidia.nix
        ./hw-nvidia.nix
        ./nvidia.nix
        ./display-manager.nix
        {nixpkgs.overlays = [fonts-overlay ffmpegAvMallocFix];}

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${username} = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs username pkgsStable;
            displayConfig = "nvidia";
            waybarConfig = "pc";
            startupConfig = "nvidia";
            deviceConfig = "nvidia";
            graphics = "nvidia";
            gpgKeygrip = "0DE4C646CC67946C9B880452C7897E02304EEC65";
          };
        }
      ];
    };
  };
}
