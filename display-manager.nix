{
  config,
  pkgs,
  ...
}: {
  # SDDM config
  services.displayManager.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    theme = "sddm-astronaut";
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
  };
}
