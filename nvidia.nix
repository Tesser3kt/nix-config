{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # Accelerated video playback
      nvidia-vaapi-driver
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
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
