{
  config,
  pkgs,
  ...
}: {
  # SDDM config
  services.displayManager.enable = true;
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland = {
      enable = true;
    };
    theme = "sddm-astronaut";
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
  };
}
