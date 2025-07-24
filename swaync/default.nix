{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./style.nix
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  # Enable swaync service
  services.swaync = {
    enable = true;
  };

  # Link icons folder
  xdg.configFile."swaync/icons".source = ./icons;
}
