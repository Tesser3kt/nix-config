{
  config,
  pkgs,
  ...
}: {
  # SDDM config
  services.displayManager.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Add astronaut theme
  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];
  services.displayManager.sddm.theme = "sddm-astronaut";
}
