{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GDM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
}
