{
  config,
  pkgs,
  ...
}: {
  # SDDM config
  services.displayManager.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
}
