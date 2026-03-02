{
  config,
  pkgs,
  lib,
  ...
}: {
  # Use an overlay to patch the nvidia beta driver
  nixpkgs.overlays = [
    (final: prev: {
      linuxKernel = prev.linuxKernel // {
        packages = lib.mapAttrs (version: kPkgs:
          if kPkgs ? nvidiaPackages then
            kPkgs // {
              nvidiaPackages = kPkgs.nvidiaPackages // {
                beta = kPkgs.nvidiaPackages.beta.overrideAttrs (oldAttrs: {
                  postUnpack = (oldAttrs.postUnpack or "") + ''
                    echo "=== Applying kernel 6.19 patch to NVIDIA open modules ==="
                    if [ -d "source/kernel-open" ]; then
                      cd source
                      ${final.patch}/bin/patch -p1 < ${./kernel-6.19.patch}
                      cd ..
                    fi
                  '';
                });
              };
            }
          else kPkgs
        ) prev.linuxKernel.packages;
      };
    })
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # Accelerated video playback
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];
}
