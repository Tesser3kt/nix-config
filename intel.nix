{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # Accelerated video playback
      intel-media-driver
      # QSV
      vpl-gpu-rt

      intel-compute-runtime
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
